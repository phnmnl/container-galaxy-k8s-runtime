
![Logo](logo.png)

# Galaxy
Version: 16.07-pheno 

## Short Description

Galaxy is an open, web-based platform for data intensive biomedical research.

## Description
Increased reliance on computational approaches in the life sciences has revealed grave concerns about how accessible and reproducible computation-reliant results truly are. Galaxy http://usegalaxy.org, an open web-based platform for genomic research, addresses these problems. Galaxy automatically tracks and manages data provenance and provides support for capturing the context and intent of computational methods. Galaxy Pages are interactive, web-based documents that provide users with a medium to communicate a complete computational analysis.

This PhenoMeNal version of Galaxy is a container capable of running inside the Kubernetes container orchestrator, and able to schedule Kubernetes jobs from the inside of the cluster. Is a lighweight container as no toolshed dependencies are needed.

The Galaxy - Kubernetes integration is a contribution made entirely by the PhenoMeNal Project to the Galaxy Project.

This release version uses the following tools, tagged at these release versions:

| Tool | Container | Tag | Maintainer | Affiliation | Docs |
|------|-----------|-----|------------|-------------|------|
| [ms-vfetc](https://github.com/leidenuniv-lacdr-abs/ms-vfetc/tree/v0.4) | [container-ms-vfetc](https://github.com/phnmnl/container-ms-vfetc/commit/cd04be499d7a2de79e0e5f93075d6d2e65902323) | [v0.4_cv1.3](http://phenomenal-h2020.eu/jenkins/view/UL%20team/job/container-ms-vfetc/10/) | Michael van Vliet | Leiden University | [docs](https://github.com/leidenuniv-lacdr-abs/ms-vfetc/blob/v0.4/README.md) |
| [iso2flux]() | [container-iso2flux](https://github.com/phnmnl/container-iso2flux/releases/tag/v0.2_cv1.0) | [v0.2_cv1.0](http://phenomenal-h2020.eu/jenkins/job/container-iso2flux/28/) | Pablo Moreno | EMBL-EBI | |
| [ramid]() | [container-ramid](https://github.com/phnmnl/container-ramid/releases/tag/v1.0_cv0.1) | [v1.0_cv0.1](http://phenomenal-h2020.eu/jenkins/job/container-ramid/7) | Pablo Moreno | EMBL-EBI | |
| [midcor]() | [container-midcor](https://github.com/phnmnl/container-midcor/releases/tag/v1.0_cv0.2) | [v1.0_cv0.2](http://phenomenal-h2020.eu/jenkins/job/container-midcor/32/) | Pablo Moreno | EMBL-EBI | |
| [mtbls-dwnloader]() | [container-scp-aspera](https://github.com/phnmnl/container-scp-aspera/releases/tag/v3.5.4.102989-linux-64_cv0.1) | [v3.5.4.102989-linux-64_cv0.1](http://phenomenal-h2020.eu/jenkins/job/container-scp-aspera/5/) | Pablo Moreno | EMBL-EBI | |
| [nmrml2isa]() | [container-nmrml2isa](https://github.com/phnmnl/container-nmrml2isa/releases/tag/v0.3.0_cv0.1) | [v0.3.0_cv0.1](http://phenomenal-h2020.eu/jenkins/job/container-nmrml2isa/10/) | P. Moreno, T. Lawson | EMBL-EBI, U. of Birmingham | |
| [mzml2isa]() | [container-mzml2isa]() | [v0.4.28_cv0.2]() | P. Moreno, K. Peters | EMBL-EBI, IPB Halle | |
| [Batman]() | [container-batman](https://github.com/phnmnl/container-batman/releases/tag/v1.2.1.0.7_cv1.0) | [v1.2.1.0.7_cv1.0](http://phenomenal-h2020.eu/jenkins/job/container-batman/34/) | P. Moreno, J. Gao | EMBL-EBI, Imperial College London | |
| [metfrag-cli]() | [container-metfrag-cli](https://github.com/phnmnl/container-metfrag-cli/releases/tag/v2.4.2_cv0.2) | [v2.4.2_cv0.2](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli/17/) | Kristian Peters | IPB Halle | |
| w4m - metabolights downloader ||||||
| [w4m - univariate]() | [container-univariate](https://github.com/phnmnl/container-univariate) | [v2.2.3_cv1.2](http://phenomenal-h2020.eu/jenkins/job/container-univariate/28/) | Pierrick Roger Mele | CEA ||
| [w4m - multivariate]() | [container-multivariate](https://github.com/phnmnl/container-multivariate) | [v2.3.10_cv1.1](http://phenomenal-h2020.eu/jenkins/job/container-multivariate/18/) | Pierrick Roger Mele | CEA ||
| [w4m - biosigner]() |[container-biosigner]|[v2.2.7_cv1.1](http://phenomenal-h2020.eu/jenkins/job/container-biosigner/12/) | Pierrick Roger Mele | CEA ||
| [w4m - LC/MS matching]() |[container-lcmsmatching](https://github.com/phnmnl/container-lcmsmatching) |[v3.1.6_cv1.3](http://phenomenal-h2020.eu/jenkins/job/container-lcmsmatching/61/)|Pierrick Roger Mele | CEA ||
| [metabolite ID converter]() | [container-MetaboliteIDConverter](https://github.com/phnmnl/container-MetaboliteIDConverter/releases/tag/v0.5.1_cv1.0) | [v0.5.1_cv1.0](http://phenomenal-h2020.eu/jenkins/job/container-metaboliteidconverter/26/) | Benjamin Merlet | INRA | |
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
- [Pierrick Roger-Mele](https://github.com/pierrickrogermele) (CEA)
- PhenoMeNal Tool Contributors.

## Website

- https://galaxyproject.org/


## Git Repository

- https://github.com/phnmnl/container-galaxy-k8s-runtime.git

## Installation 

This Galaxy deployment will be available at all PhenoMeNal CRE deployments (cloud, bare-metal, development, etc).

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
helm install galaxy-helm-repo/galaxy-simple
```

This helm chart accepts plenty of options, and there is also another helm chart for production deployment with more options. For more details see [this link](https://github.com/phnmnl/phenomenal-h2020/wiki/QuickStart-Installation-for-Local-PhenoMeNal-Workflow).




## Usage Instructions

On PhenoMeNal CRE deployments, you will be given a link if deployed through the PhenoMeNal App Portal. The instance will be secured for the email and password that you provided during setup.

If deployed locally on Minikube using Helm, most likely you access URL will be http://192.168.99.100:30700. This could vary if the internal Minikube IP is different (although port should be the same).

For direct docker usage:

```bash
docker run -p 8080:8080 container-registry.phenomenal-h2020.eu/phnmnl/galaxy-k8s-runtime
```

and in this case it should become accessible at localhost:8080 on your browser.

## Publications

- Goecks, J., Nekrutenko, A., & Taylor, J. (2010). Galaxy: a comprehensive approach for supporting accessible, reproducible, and transparent computational research in the life sciences. Genome biology, 11(8), 1.
