
![Logo](logo.png)

# Galaxy
Version: 17.09-pheno 

## Short Description

Galaxy is an open, web-based platform for data intensive biomedical research.

## Description
Increased reliance on computational approaches in the life sciences has revealed grave concerns about how accessible and reproducible computation-reliant results truly are. Galaxy http://usegalaxy.org, an open web-based platform for genomic research, addresses these problems. Galaxy automatically tracks and manages data provenance and provides support for capturing the context and intent of computational methods. Galaxy Pages are interactive, web-based documents that provide users with a medium to communicate a complete computational analysis.

This PhenoMeNal version of Galaxy is a container capable of running inside the Kubernetes container orchestrator, and able to schedule Kubernetes jobs from the inside of the cluster. It is a lighweight container as no toolshed dependencies are needed. The current version includes on top of Galaxy 17.09 PhenoMeNal additions to the Galaxy code base:

- Ability to limit resources per tools (CPU and RAM) inside Kubernetes.
- ISA-tab and ISA-json native Composite datatype support in Galaxy.

The Galaxy - Kubernetes integration and Galaxy helm charts are contributions made entirely by the PhenoMeNal Project to the Galaxy Project.

This release version uses the tools listed in this [table](https://github.com/phnmnl/container-galaxy-k8s-runtime/blob/master/cerebellin-tools.md), tagged at the specified release versions.

Note: maintainers are for containers, not necessarily tool authors. Follow links to learn about tool authors.


## Key features

- Platform for containerised tools
- Workflows

## Functionality

- Workflows

## Approaches
  
## Instrument Data Types

## Screenshots

## Tool Authors

- Jeremy Goecks (Emory University)
- Seth C. Schommer (Penn State University)
- James Taylor (Emory University)

## Container Contributors

- [Pablo Moreno](https://github.com/pcm32) (EMBL-EBI)
- [Luca Pireddu](https://github.com/ilveroluca) (CRS4)
- [Pierrick Roger](https://github.com/pkrog) (CEA)
- [David Johnson](https://github.com/djcomlab) (U. of Oxford)
- PhenoMeNal Tool Contributors.

## Website

- https://galaxyproject.org/


## Git Repository

- https://github.com/phnmnl/container-galaxy-k8s-runtime.git

## Installation 

This Galaxy deployment will be available at all **PhenoMeNal CRE deployments** (cloud, bare-metal, development, etc), which can be created through the [PhenoMeNal Portal](https://portal.phenomenal-h2020.eu/) or by using more advanced methods.

If you want to install it locally as a docker container:

```bash
docker pull container-registry.phenomenal-h2020.eu/phnmnl/galaxy-k8s-runtime
```

However, please note that this image is not entirely functional without running inside or connected somehow to a Kubernetes cluster.

If you have a Kubernetes cluster (or a Minikube instance), it can be deployed through Helm:

```bash
# first time only
helm repo add galaxy-helm-repo https://pcm32.github.io/galaxy-helm-charts
# and then everytime you want to deploy
helm install galaxy-helm-repo/galaxy
```

This helm chart accepts plenty of options, and there is also another helm chart for production deployment with more options. For more details see [this link](https://github.com/phnmnl/phenomenal-h2020/wiki/QuickStart-Installation-for-Local-PhenoMeNal-Workflow) or the [helm repo for Galaxy](https://github.com/galaxyproject/galaxy-kubernetes/blob/master/README.md).


## Usage Instructions

On PhenoMeNal CRE deployments, you will be given a link if deployed through the [PhenoMeNal Portal](https://portal.phenomenal-h2020.eu/). The instance will be secured for the email and password that you provided during setup. 

To use it at the [PhenoMeNal Public instance](https://public.phenomenal-h2020.eu/) you will need to register through the [PhenoMeNal Portal](https://portal.phenomenal-h2020.eu/home), by clicking on "Create your cloud research environment", sign-in through the Elixir Single-sign-on with your Google or institutional account, and then choose "PhenoMeNal Cloud", where you will be able to create an account for the public instance.

If deployed locally on Minikube using Helm, most likely you access URL will be http://192.168.99.100:30700. This could vary if the internal Minikube IP is different (although port should be the same).

For direct docker usage: this image is not meant to be used directly with docker only.

## Publications

- Goecks, J., Nekrutenko, A., & Taylor, J. (2010). Galaxy: a comprehensive approach for supporting accessible, reproducible, and transparent computational research in the life sciences. Genome biology, 11(8), 1.
