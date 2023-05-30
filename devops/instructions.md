# Instructions

> Please place your answers or any instructions for your implementation in this document.
> If you require an Azure subscription to test your scripts please create a free Azure subscription [here](https://azure.microsoft.com/en-in/free/).
> If you require an Azure DevOps environment to test your pipelines please create a free Azure DevOps organization [here](https://azure.microsoft.com/en-us/products/devops/?nav=min).

# Notes

This project was done using my Azure DevOps organization built-in repository.

A clone of the repository is located in the same directory as this file, under subdirectory `divergent-v2`.

# Docker Images

This deployment creates 4 docker images:  
  1. sales api
  2. shipping api
  3. composition gatewy
  4. website

## Location of components

1. Working directory:  
&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/docker/

2. Docker files:
    - \<repository-root\>/deploy/docker/docker-files/divergent-composition-gateway  
    - \<repository-root\>/deploy/docker/docker-files/divergent-sales-api  
    - \<repository-root\>/deploy/docker/docker-files/divergent-shipping-api  
    - \<repository-root\>/deploy/docker/docker-files/divergent-website  

## Building the Docker Images Locally

### Using `docker build` directly

Should you choose to build the images by using `docker build` directly, the following steps must be followed:

**NB:** In the commands that follow, all \<...\> placeholders must be replaced with suitable values.

  1. Change to the docker working directory:  
  `cd <repository-root>/deploy/docker`

  2. Copy the latest source code to the working (build) directory:  
  `mkdir -v source`  
  `cp -Ruv <repository-root>/source/divergent-images/* source`

  3. To build a particular image run the command:  
  `docker build -f ./docker-files/<image-file> -t <image-name>:<image-tag>`

### Using the custom bash script

The included script greatly simplify the image building process. It is located at  

&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/docker/build-divergent-images.sh

Benefits of using the script include:

  - Required source is automatically copied to the docker build directory and removed after image building has completed.
  - The image or images to be built are passed to the script as arguments, so any combination of images may be built by a single execution of the script.
  - Unlike the native `docker build` commands, it is not necessary to first change to the docker build directory. The script may be called from any directory (by providing its full path).

Run `build-divergent-images.sh -h` or `build-divergent-images.sh --help` for information on how to use the script.

# Running clusters with docker compose

It is possible to run the following clusters for local testing by using `docker compose`:

  1. Back-end APIs (Sales, Shipping) and the Composition Gateway.
  2. Back-end APIs (Sales, Shipping) and the Website.
  3. Back-end APIs (Sales, Shipping), Composition Gateway, and the Website.

## Location of components

1. Working directory:  
&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/docker/compose/

2. Compose files
    - \<repository-root\>/deploy/docker/compose/divergent-composition-gateway/compose.yaml
    - \<repository-root\>/deploy/docker/compose/divergent-website/compose.yaml
    - \<repository-root\>/deploy/docker/compose/divergent-cluster-full/compose.yaml

## Running the Docker Clusters Locally

### Using `docker ompose` directly

Should you choose to run a cluster by using `docker compose` directly, the following steps must be followed:

**NB:** In the commands that follow, all \<...\> placeholders must be replaced with suitable values.

  1. Create the network `divergent-net` if it doesn't exist.
      1. You can run `docker network ls` to list existing docker networks.
      2. If `divergent-net` does not exist, create it by running:  
      `docker network create divergent-net`

  2. Change to the docker working directory:  
  `cd <repository-root>/deploy/docker/compose/<compose-cluster-directory>/`

  3. Start the cluster:  
  `docker compose up`

### Using the custom bash script

The included script makes it less cumbersome to start a cluster. It is located at  

&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/docker/run-cluster.sh

Benefits of using the script include:

  - A cluster may be selected interactively or be passed non-interactively as a command-line argument.
  - The script takes care of the required networking.
  - Unlike the native `docker compose` commands, it is not necessary to first change to the docker compose directory. The script may be called from any directory (by providing its full path).

Run `run-cluster.sh -h` or `run-cluster.sh --help` for information on how to use the script.

# Terraform

The included terraform scripts facilitate creation of the following Azure resources:

  - Resource group: rg-tangent-divergent
  - Container registry: DivergentImages

## Location of components

1. Working directory:  
&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/terraform/

2. Terraform scripts:
    - \<repository-root\>/deploy/terraform/main.tf
    - \<repository-root\>/deploy/terraform/variables.tf

## Running the terraform script

**NB:** In the commands that follow, all \<...\> placeholders must be replaced with suitable values.

  1. Change to the docker working directory:  
  `cd <repository-root>/deploy/terraform/`

  2. Initialize terraform:  
  `terraform init`

  3. Optional: Validate the configuration:  
  `terraform validate`

  4. Apply the changes:  
  `terraform apply`

# Helm Chart

The helm chart has been implemented as a single chart deploying the website, with subcharts for the backend APIs and the Composition Gateway.

## Location of components

1. Working directory:  
&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/helm/

2. Helm chart:
    - \<repository-root\>/deploy/helm/divergent-website/

## Chart deployment

**NB:** In the commands that follow, all \<...\> placeholders must be replaced with suitable values.

The command below may be used to deploy the chart into namespace `divergent`:  

`helm upgrade \`  
`--install \`  
`--namespace=divergent \`  
`--set divergent-sales-api.image.tag=newest,divergent-shipping-api.image.tag=newest,divergent-composition-gateway.image.tag=newest,image.tag=newest \`  
`<deployment-name> \`  
`<repository-root>/deploy/helm/divergent-website`

# Azure Pipelines

The following pipelines were created and tested:

  1. terraform-create-infrastructure  
  This pipeline runs the terraform script above for creating the Azure resource group and container registry.

  2. terraform-destroy-infrastructure  
  This pipeline may be triggered manually to destroy the infrastructure created by `terraform-create-infrastructure`.

  3. divergent-v2-build-and-push-images  
  This pipeline builds each container image and pushes it to the container registry.  
  The pipeline is triggered by source updates in the following paths:
        - \<repository-root\>/deploy/docker/
        - \<repository-root\>/deploy/helm/
        - \<repository-root\>/source/divergent-images/

  4. divergent-v2-deployment
  This pipeline deploys the above helm chart.  
  It is triggered by successful build completion of the `divergent-v2-build-and-push-images` pipeline.

## Location of components

1. Working directory:  
&nbsp;&nbsp;&nbsp;&nbsp;\<repository-root\>/deploy/azure-pipelines/

2. Pipeline configuration files (`json` and `yaml` versions):  
    - \<repository-root\>//deploy/azure-pipelines/terraform-create-infrastructure.json
    - \<repository-root\>//deploy/azure-pipelines/terraform-create-infrastructure.yml
    - \<repository-root\>//deploy/azure-pipelines/terraform-destroy-infrastructure.json
    - \<repository-root\>//deploy/azure-pipelines/terraform-destroy-infrastructure.yml
    - \<repository-root\>//deploy/azure-pipelines/divergent-v2-build-and-push-images.json
    - \<repository-root\>//deploy/azure-pipelines/divergent-v2-build-and-push-images.yml
    - \<repository-root\>//deploy/azure-pipelines/divergent-v2-deployment.json
    - \<repository-root\>//deploy/azure-pipelines/divergent-v2-deployment.yml
