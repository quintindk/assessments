# DevOps Engineer

This document is used to test possible candidate's capabilities for a DevOps Engineer at different levels position. The idea here is to complete the section under Requirements based on the position you are applying for.

In your response to this assessment:

1. Create a fork of **this** repository to your own github account,
2. Create pull request to your **own account repository**, please do not create a PR to this repository as this will be problematic,
3. Add me as a reviewer to your PR.

The evaluation will be performed as follows:

1. The PR from your **own account repository** will be git pulled down to a virtual machine and then the commands in your instructions will be run,
2. If the instructions `instructions.md` are not available the contents of the repository will be evaluated.

> Please do not create a PR to this repository.

## Problem Statement

In this use case the client has created an ASP.NET web application and services for an e-commerce application. The code and description for this application can be found at [https://github.com/quintindk/workshop/tree/master/demos/asp-net-core](https://github.com/quintindk/workshop/tree/master/demos/asp-net-core). The customer has a few additional requirements that are highlighted in the different sections below.

## Requirements

The following sections describe what is required by you as a candidate for the applicable position.

### Junior DevOps Engineer

<details>
  <summary>User stories...</summary>

1. As a Junior DevOps engineer you are required to create a docker file that will build the `Divergent.Sales.API` component for the backend APIs so that they can be built on a developers machine. Please be sure to name the docker file and provide instructions for building the container image on the local machine.

2. As a Junior DevOps engineer you are required to create a docker file that will build the `Divergent.Shipping.API` component for the backend APIs so that they can be built on a developers machine. Please be sure to name the docker file and provide instructions for building the container image on the local machine.

3. As a Junior DevOps engineer you are required to create a docker file that will build the `Divergent.CompositionGateway` component for the backend APIs so that they can be built on a developers machine. Please be sure to name the docker file and provide instructions for building the container image on the local machine.

4. As a Junior DevOps engineer you are required to create a docker file that will build the `Divergent.Website` component for the backend APIs so that they can be built on a developers machine. Please be sure to name the docker file and provide instructions for building the container image on the local machine.

5. As a Junior DevOps engineer you are required to create a docker compose definition to build and run all components for the web site on the developers local machine so that the developer can test the application. Please be sure to name the docker compose file and provide instructions for running the docker compose to test the web site system.

6. As a Junior DevOps engineer you are required to create a docker compose definition to build and run all components for the backend APIs on the developers local machine so that the developer can test the composition apis. Please be sure to name the docker compose file and provide instructions for running the docker compose to test the API system.

</details>

### DevOps Engineer

> If you require an Azure subscription to test your scripts please create a free Azure subscription [here](https://azure.microsoft.com/en-in/free/).
> If you require an Azure DevOps environment to test your pipelines please create a free Azure DevOps organization [here](https://azure.microsoft.com/en-us/products/devops/?nav=min).

<details>
  <summary>User stories...</summary>

1. As a DevOps engineer you are required to create 4 docker files that will build and start the components for the backend APIs and the Web Site so that they can be hosted on a developers machine. Please be sure to name the docker file and provide instructions for building the container image on the local machine.

2. As a DevOps engineer you are required to create a terraform script to create a Resource Group and an Azure Container Registry in an azure subscription so that the 4 container images in point 1 can be pushed to a central container registry. Please be sure to provide instructions for the running of the terraform script.

3. As a DevOps engineer you are required to create an automated pipeline using Azure Pipelines in Azure DevOps that will run the terraform script to create the Resource Group and an Azure Container Registry in Azure so that the creation of the of the resources is done through a service principal rather than a user account. Please be sure to provide instructions registering the pipeline and any requirements for the service principal.

4. As a DevOps engineer you are required to create an automated pipeline using Azure Pipelines in Azure DevOps that will build the container images on the build agent and push the containers to an Azure Container Registry so that the container images are available in a central container registry.

</details>

### Senior DevOps Engineer

> If you require an Azure subscription to test your scripts please create a free Azure subscription [here](https://azure.microsoft.com/en-in/free/).
> If you require an Azure DevOps environment to test your pipelines please create a free Azure DevOps organization [here](https://azure.microsoft.com/en-us/products/devops/?nav=min).

<details>
  <summary>User stories...</summary>

1. As a Senior DevOps engineer you are required to create 4 docker files that will build and start the components for the backend APIs and the Web Site so that they can be hosted on a developers machine. Please be sure to name the docker file and provide instructions for building the container image on the local machine.

2. As a Senior DevOps engineer you are required to create a terraform script to create a Resource Group and an Azure Container Registry in an azure subscription so that the 4 container images in point 1 can be pushed to a central container registry. Please be sure to provide instructions for the running of the terraform script.

3. As a Senior DevOps engineer you are required to create an automated pipeline using Azure Pipelines in Azure DevOps that will run the terraform script to create the Resource Group and an Azure Container Registry in Azure so that the creation of the of the resources is done through a service principal rather than a user account. Please be sure to provide instructions registering the pipeline and any requirements for the service principal.

4. As a Senior DevOps engineer you are required to create an automated pipeline using Azure Pipelines in Azure DevOps that will build the container images on the build agent and push the containers to an Azure Container Registry so that the container images are available in a central container registry.

5. As a Senior DevOps engineer you are required to create a terraform script to create a Resource Group and an Azure Kubernetes Service instance in an azure subscription so that the 4 container images can be deployed as separate deployments in kubernetes. Please be sure to provide instructions for the running of the terraform script.

6. As a Senior DevOps engineer you are required to create a helm chart for the deployment of the whole system i.e. all 4 containers as deployments, applicable services and applicable ingresses, so that the system can be deployed to a Azure Kubernetes Service through a single helm call. Please be sure to provide instructions for running the helm command for the installation of the system to Kubernetes.

7. As a Senior DevOps engineer you are required to create an automated pipeline using Azure Pipelines in Azure DevOps that will run the helm install task for the installation of the system to Kubernetes so that the creation of the Kubernetes resources is done through a service principal and in an automated fashion. Please be sure to provide instructions registering the pipeline and any requirements for the service principal and service connections.

</details>

## Conclusion

Thank you for your time on this, I know it's difficult to find the time to build something like this for an interview but it is appreciated by my whole team and our company.
