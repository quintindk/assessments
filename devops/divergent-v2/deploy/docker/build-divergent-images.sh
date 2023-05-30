#!/bin/bash

# set -x

. $(dirname "${0}")/helper.shsrc

process_vars+=( [source-path-relative]="../../source/divergent-images" [dockerfile-dir-relative]="docker-files" [dockerbuild-source-dir-relative]="source" [image-tag]="latest" )
process_vars[dockerfile-dir-relative]="${process_vars[workdir]}/${process_vars[dockerfile-dir-relative]}"
declare -a all_images=( "divergent-sales-api" "divergent-shipping-api" "divergent-composition-gateway" "divergent-website" )
declare -a selected images

help () {
    cat <<- eof
	
		SYNOPSIS
		    $(basename "${0}") [ <option> | <image>... ]

		DESCRIPTION
		    Build docker images for Divergent APIs, Composition Gateway, and Website

		    When called without options or arguments this help screen is displayed.

		OPTIONS
		    -h, --help
		        Print this help screen.
	
		    -a, --all
		        Build all images.
	
		    -l, --list
		        List all images available to build.
	
		    -t <value>, --tag=<value>
		        Provide a tag for the image(s). 
		        If this option is not specified, a default tag with value 'latest' is used.
	
		ARGUMENTS
		    <image>...
		        Specify the images to build. The full list may be viewed with the --list option.
		        To build all images, it is more convenient to use the --all option instead.
				

	eof
}

get_sources () {
    declare -n args
    args=${1}
    mkdir -pv ${args[dockerbuild-source-dir-relative]}
    cp -Ruv ${args[source-path-relative]}/* ${args[dockerbuild-source-dir-relative]}/
}

rm_sources () {
    declare -n args
    args=${1}
    rm -frv ${args[dockerbuild-source-dir-relative]}
}

process_args () {
    ((${#}==2)) && help && exit
    declare -a cli_args
    declare -n images
    images="${1}"
    declare -n selected="${2}"
    shift 2
    while [ -n "${1}" ]; do
        case "${1}" in
            -h|--help )
                help && exit
                ;;
            -a|--all )
                cli_args=( ${images[@]} )
                break
                ;;
            -l|--list )
                printf "Images available to build:\n"
                printf "\t%s\n" "${all_images[@]}"
                exit
                ;;
            -t|--tag=* )
                if [[ "${1}" == "-t" ]]; then
                    shift
                fi
                process_vars[image-tag]=$(sed -E -- "s/--tag=//" <<< "${1}")
                ;;
            * )
                for image in "${all_images[@]}"; do
                    [[ "${image}" == "${1}" ]] && cli_args+=( "${1}" ) && break
                done
                ;;
        esac
    shift
    done
    selected=( $(printf "%s\n" "${cli_args[@]}"|sort|uniq) )
}

process_args all_images selected_images "${@}"

pushd ${process_vars[workdir]}

# Build the images
if ((${#selected_images[@]}>0)); then
    if get_sources process_vars; then
        for image in ${selected_images[@]}; do
            docker build -f ./docker-files/${image} -t ${image}:"${process_vars[image-tag]}" .
        done
    else
        print_log "${messages[term]}" "Unable to copy sources to docker build directory"
        exit 1
    fi

    # Clean up after ourselves
    if rm_sources process_vars; then
        print_log "${messages[info]}" "Removed sources from docker build directory"
    else
        print_log "${messages[error]}" "Failed to remove sources from docker build directory"
    fi
fi

popd
