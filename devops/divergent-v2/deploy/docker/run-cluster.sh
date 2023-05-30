#!/bin/bash

# set -x

. $(dirname "${0}")/helper.shsrc

process_vars+=(
    [divergent-composition-gateway]="compose/divergent-composition-gateway"
    [divergent-website]="compose/divergent-website"
    [divergent-cluster-full]="compose/divergent-cluster-full"
    [valid-cli-arg]=false [selected-cluster]=""
    [docker-network]="divergent-net"
)
declare -A clusters=( [gateway]="divergent-composition-gateway" [website]="divergent-website" [all]="divergent-cluster-full" )

help () {
    cat <<- eof
	
		SYNOPSIS
		    $(basename "${0}") [ <option> | <cluster> ]

		DESCRIPTION
		    Start a cluster for the Divergent-Composition-API or Divergent-Website using 'docker compose'.

		    When called without arguments the user can interactively select which cluster to start.

		    Containers are automatically removed after the cluster has been taken down.

		OPTIONS
		    -h, --help
		        Print this help screen.
	
		    -l, --list
		        List all available clusters.
	
		ARGUMENTS
		    <cluster>
		        Specify the cluster to start. Valid values are
				$(for x in "${clusters[@]}"; do printf "\t\t%s\n" "${x}"; done)

		        Any arguments after the first are ignored.

	eof
}

run_cluster () {
    local compose_path="${1}"
    pushd "${compose_path}"
    docker network ls|grep -E "${process_vars[docker-network]}" || docker network create ${process_vars[docker-network]}
    docker compose up
    docker compose down
    popd
}

if [ -z "${1}" ]; then
    printf "Select the number corresponding to the cluster you want to run:\n"
    select cluster in "${clusters[@]}" exit; do
        [ -z "${cluster}" ] && print_log "${messages[term]}" "Invalid choice; rerun this script and select a valid option" && exit
        [[  "${cluster}" == "exit" ]] && exit
        run_cluster "${process_vars[workdir]}/${process_vars[${cluster}]}"
        break
    done
    exit
fi

case "${1}" in
    -h|--help )
        help && exit
        ;;
    -l|--list )
        printf "Available clusters:\n"
        printf "\t%s\n" "${clusters[@]}"
        exit
        ;;
    * )
        process_vars[valid-cli-arg]=false
        for cluster in "${clusters[@]}"; do
            [[ "${cluster}" == "${1}" ]] && process_vars[valid-cli-arg]=true && process_vars[selected-cluster]="${1}" && break
        done
        ;;
esac

${process_vars[valid-cli-arg]} && run_cluster "${process_vars[workdir]}/${process_vars[${process_vars[selected-cluster]}]}"
