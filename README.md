
![Logo](logo.png)

# Galaxy
Version: 17.05-pheno 

## Short Description

Galaxy is an open, web-based platform for data intensive biomedical research.

## Description
Increased reliance on computational approaches in the life sciences has revealed grave concerns about how accessible and reproducible computation-reliant results truly are. Galaxy http://usegalaxy.org, an open web-based platform for genomic research, addresses these problems. Galaxy automatically tracks and manages data provenance and provides support for capturing the context and intent of computational methods. Galaxy Pages are interactive, web-based documents that provide users with a medium to communicate a complete computational analysis.

This PhenoMeNal version of Galaxy is a container capable of running inside the Kubernetes container orchestrator, and able to schedule Kubernetes jobs from the inside of the cluster. Is a lighweight container as no toolshed dependencies are needed.

The Galaxy - Kubernetes integration is a contribution made entirely by the PhenoMeNal Project to the Galaxy Project.

This release version uses the following tools, tagged at these release versions:

| Tool | Container | Tag | Maintainer | Affiliation | Docs |
|------|-----------|-----|------------|-------------|------|
 | [BATMAN]() | [container-BATMAN](https://github.com/phnmnl/container-BATMAN/releases/tag/v1.2.12.0_cv1.0) | [v1.2.12.0_cv1.0.65](http://phenomenal-h2020.eu/jenkins/job/container-BATMAN/65/) | Jianliang Gao / Pablo Moreno | Imperial College London, EMBL-EBI | |
 | [Biosigner]() | [container-Biosigner](https://github.com/phnmnl/container-Biosigner/releases/tag/v2.2.7_cv1.1) | [v2.2.7_cv1.1.12](http://phenomenal-h2020.eu/jenkins/job/container-Biosigner/12/) | Pierrick Roger | CEA | |
 | [CAMERA]() | [container-CAMERA](https://github.com/phnmnl/container-CAMERA/releases/tag/v1.32.0_cv0.5) | [v1.32.0_cv0.5.45](http://phenomenal-h2020.eu/jenkins/job/container-CAMERA/45/) | Christoph Ruttkies | IPB Halle | |
 | [Create ISA in Galaxy]() | [container-isatab-create](https://github.com/phnmnl/container-isatab-create/releases/tag/dev_v0.9.5_cv0.3.10.52 ) | [dev_v0.9.5_cv0.3.10.52 ](http://phenomenal-h2020.eu/jenkins/job/container-isatab-create/52/) | David Johnson | U. of Oxford | |
 | [escher-fluxomics]() | [container-escher-fluxomics](https://github.com/phnmnl/container-escher-fluxomics/releases/tag/v1.6.0-beta.4_cv1.0) | [v1.6.0-beta.4_cv1.0.9](http://phenomenal-h2020.eu/jenkins/job/container-escher-fluxomics/9/) | Pablo Moreno | EMBL-EBI | |
 | [Get data files list]() | [container-mtblisa](https://github.com/phnmnl/container-mtblisa/releases/tag/v0.9.5_cv0.6.7.79) | [v0.9.5_cv0.6.7.79](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa/79/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI | |
 | [Get data files collection]() | [container-mtblisa](https://github.com/phnmnl/container-mtblisa/releases/tag/v0.9.5_cv0.6.7.79) | [v0.9.5_cv0.6.7.79](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa/79/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI | |
 | [Get study factors]() | [container-mtblisa](https://github.com/phnmnl/container-mtblisa/releases/tag/v0.9.5_cv0.6.7.79) | [v0.9.5_cv0.6.7.79](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa/79/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI | |
 | [Get study factors summary]() | [container-mtblisa](https://github.com/phnmnl/container-mtblisa/releases/tag/v0.9.5_cv0.6.7.79) | [v0.9.5_cv0.6.7.79](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa/79/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI | |
 | [Get study factor values]() | [container-mtblisa](https://github.com/phnmnl/container-mtblisa/releases/tag/v0.9.5_cv0.6.7.79) | [v0.9.5_cv0.6.7.79](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa/79/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI | |
 | [isatab-validator]() | [container-isatab-validator](https://github.com/phnmnl/container-isatab-validator/releases/tag/v0.9.5_cv0.6.36) | [v0.9.5_cv0.6.36](http://phenomenal-h2020.eu/jenkins/job/container-isatab-validator/36/) | David Johnson | U. of Oxford | |
 | [isatab2json]() | [container-isatab2json](https://github.com/phnmnl/container-isatab2json/releases/tag/v0.9.5_cv0.6.62) | [v0.9.5_cv0.6.62](http://phenomenal-h2020.eu/jenkins/job/container-isatab2json/62/) | David Johnson | U. of Oxford | |
 | [iso2flux]() | [container-iso2flux](https://github.com/phnmnl/container-iso2flux/releases/tag/v0.2_cv1.1) | [v0.2_cv1.1.36](http://phenomenal-h2020.eu/jenkins/job/container-iso2flux/36/) | Pablo Moreno | EMBL-EBI | |
 | [isodyn]() | [container-isodyn](https://github.com/phnmnl/container-isodyn/releases/tag/v1.0_cv0.2) | [v1.0_cv0.2.30](http://phenomenal-h2020.eu/jenkins/job/container-isodyn/30/) | Pablo Moreno | EMBL-EBI | |
 | [jupyter]() | [container-jupyter](https://github.com/phnmnl/container-jupyter/releases/tag/v387f29b6ca83_cv0.4) | [v387f29b6ca83_cv0.4.7](http://phenomenal-h2020.eu/jenkins/job/container-jupyter/7/) | Marco Capuccini, Pablo Moreno | Uppsala U., EMBL-EBI | |
 | [lcmsmatching]() | [container-lcmsmatching](https://github.com/phnmnl/container-lcmsmatching/releases/tag/v3.1.6_cv1.3) | [v3.1.6_cv1.3.61](http://phenomenal-h2020.eu/jenkins/job/container-lcmsmatching/61/) | Pierrick Roger | CEA | |
 | [Luigi]() | [container-Luigi](https://github.com/phnmnl/container-Luigi/releases/tag/v2.6.0_cv0.1) | [v2.6.0_cv0.1.5](http://phenomenal-h2020.eu/jenkins/job/container-Luigi/5/) | Marco Capuccini, Pablo Moreno | Uppsala U., EMBL-EBI | |
 | [Metabolights downloader (scp-aspera)]() | [container-Metabolights downloader (scp-aspera)](https://github.com/phnmnl/container-scp-aspera/releases/tag/v3.5.4.102989-linux-64_cv0.2) | [v3.5.4.102989-linux-64_cv0.2.9](http://phenomenal-h2020.eu/jenkins/job/container-scp-aspera/9/) | Pablo Moreno | EMBL-EBI | |
 | [MetaboliteIDConverter]() | [container-MetaboliteIDConverter](https://github.com/phnmnl/container-MetaboliteIDConverter/releases/tag/v0.5.1_cv1.1) | [v0.5.1_cv1.1.28](http://phenomenal-h2020.eu/jenkins/job/container-MetaboliteIDConverter/28/) | Benjamin Merlet | INRA | |
 | [metabomatching]() | [container-metabomatching](https://github.com/phnmnl/container-metabomatching/releases/tag/v0.1.0_cv0.3) | [v0.1.0_cv0.3.29](http://phenomenal-h2020.eu/jenkins/job/container-metabomatching/29/) | Rico Rueedi | U. of Lausanne | |
 | [metfrag-cli]() | [container-metfrag-cli](https://github.com/phnmnl/container-metfrag-cli/releases/tag/v2.4.2_cv0.3) | [v2.4.2_cv0.3.24](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli/24/) | Christoph Ruttkies | IPB Halle | |
 | [metfrag-cli-batch]() | [container-metfrag-cli-batch](https://github.com/phnmnl/container-metfrag-cli-batch/releases/tag/v2.4.2_cv0.1) | [v2.4.2_cv0.1.12](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli-batch/12/) | Christoph Ruttkies | IPB Halle | |
 | [metfrag-vis]() | [container-metfrag-vis](https://github.com/phnmnl/container-metfrag-vis/releases/tag/v0.1_cv0.1) | [v0.1_cv0.1.12](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-vis/12/) | Christoph Ruttkies | IPB Halle | |
 | [midcor]() | [container-midcor](https://github.com/phnmnl/container-midcor/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.39](http://phenomenal-h2020.eu/jenkins/job/container-midcor/39/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona | |
 | [ms-vfetc]() | [container-ms-vfetc](https://github.com/phnmnl/container-ms-vfetc/releases/tag/v0.4_cv1.3) | [v0.4_cv1.3.10](http://phenomenal-h2020.eu/jenkins/job/container-ms-vfetc/10/) | Michael van Vliet | Leiden University | |
 | [msnbase]() | [container-msnbase](https://github.com/phnmnl/container-msnbase/releases/tag/v2.0.2_cv0.2) | [v2.0.2_cv0.2.42](http://phenomenal-h2020.eu/jenkins/job/container-msnbase/42/) | Kristian Peters, Payam Emami | IPB Halle, Uppsala U. | |
 | [mtbl-labs-uploader]() | [container-mtbl-labs-uploader](https://github.com/phnmnl/container-mtbl-labs-uploader/releases/tag/v0.1.0_cv0.3) | [v0.1.0_cv0.3.11](http://phenomenal-h2020.eu/jenkins/job/container-mtbl-labs-uploader/11/) | Pablo Moreno | EMBL-EBI | |
 | [mtbls-dwnld]() | [container-mtbls-dwnld](https://github.com/phnmnl/container-mtbls-dwnld/releases/tag/v2.0.5_cv1.2) | [v2.0.5_cv1.2.16](http://phenomenal-h2020.eu/jenkins/job/container-mtbls-dwnld/16/) | Pierrick Roger | CEA | |
 | [mtbls-factors-viz]() | [container-mtbls-factors-viz](https://github.com/phnmnl/container-mtbls-factors-viz/releases/tag/v0.4_cv0.3) | [v0.4_cv0.3.11](http://phenomenal-h2020.eu/jenkins/job/container-mtbls-factors-viz/11/) | Pablo Moreno | EMBL-EBI | |
 | [Multivariate]() | [container-Multivariate](https://github.com/phnmnl/container-Multivariate/releases/tag/v2.3.10_cv1.1) | [v2.3.10_cv1.1.18](http://phenomenal-h2020.eu/jenkins/job/container-Multivariate/18/) | Pierrick Roger | CEA | |
 | [mw2isa]() | [container-mw2isa](https://github.com/phnmnl/container-mw2isa/releases/tag/v0.5.0_cv0.1) | [v0.5.0_cv0.1.20](http://phenomenal-h2020.eu/jenkins/job/container-mw2isa/20/) | Phillipe Rocaserra | U. of Oxford | |
 | [mzML2isa]() | [container-mzML2isa](https://github.com/phnmnl/container-mzML2isa/releases/tag/v0.4.28_cv0.2) | [v0.4.28_cv0.2.23](http://phenomenal-h2020.eu/jenkins/job/container-mzML2isa/23/) | Pablo Moreno, Thomas Lawson | EMBL-EBI, U. of Birmingham | |
 | [nmrML2isa]() | [container-nmrML2isa](https://github.com/phnmnl/container-nmrML2isa/releases/tag/v0.3.0_cv0.1) | [v0.3.0_cv0.1.10](http://phenomenal-h2020.eu/jenkins/job/container-nmrML2isa/10/) | Pablo Moreno, Thomas Lawson | EMBL-EBI, U. of Birmingham | |
 | [nmrmlconv]() | [container-nmrmlconv](https://github.com/phnmnl/container-nmrmlconv/releases/tag/v1.1b_cv0.4) | [v1.1b_cv0.4.46](http://phenomenal-h2020.eu/jenkins/job/container-nmrmlconv/46/) | Kristian Peters | IPB Halle | |
 | [openms]() | [container-openms](https://github.com/phnmnl/container-openms/releases/tag/v2.1.0_cv0.2) | [v2.1.0_cv0.2.15](http://phenomenal-h2020.eu/jenkins/job/container-openms/15/) | Christoph Ruttkies | IPB Halle | |
 | [papy]() | [container-papy](https://github.com/phnmnl/container-papy/releases/tag/v2.0_cv1.0) | [v2.0_cv1.0.25](http://phenomenal-h2020.eu/jenkins/job/container-papy/25/) | Jianliang Gao | Imperial College London | |
 | [ramid]() | [container-ramid](https://github.com/phnmnl/container-ramid/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.14](http://phenomenal-h2020.eu/jenkins/job/container-ramid/14/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona | |
 | [rbase]() | [container-rbase](https://github.com/phnmnl/container-rbase/releases/tag/v3.4.1-1xenial0_cv0.2) | [v3.4.1-1xenial0_cv0.2.12](http://phenomenal-h2020.eu/jenkins/job/container-rbase/12/) | Kristian Peters, Pablo Moreno | IPB Halle, EMBL-EBI | |
 | [rNMR]() | [container-rNMR](https://github.com/phnmnl/container-rNMR/releases/tag/v1.1.9_cv0.2) | [v1.1.9_cv0.2.1024](http://phenomenal-h2020.eu/jenkins/job/container-rNMR/1024/) | Kristian Peters | IPB Halle | |
 | [rNMR-1D]() | [container-rNMR-1D](https://github.com/phnmnl/container-rNMR-1D/releases/tag/v1.2.8_cv0.3) | [v1.2.8_cv0.3.22](http://phenomenal-h2020.eu/jenkins/job/container-rNMR-1D/22/) | Kristian Peters | IPB Halle | |
 | [SOAP-NMR]() | [container-SOAP-NMR](https://github.com/phnmnl/container-SOAP-NMR/releases/tag/v1.0_cv0.4) | [v1.0_cv0.4.1016](http://phenomenal-h2020.eu/jenkins/job/container-SOAP-NMR/1016/) | Kristian Peters | IPB Halle | |
 | [Univariate]() | [container-Univariate](https://github.com/phnmnl/container-Univariate/releases/tag/v2.2.3_cv1.2) | [v2.2.3_cv1.2.28](http://phenomenal-h2020.eu/jenkins/job/container-Univariate/28/) | Pierrick Roger | CEA | |
 | [xcms]() | [container-xcms](https://github.com/phnmnl/container-xcms/releases/tag/v1.52.0_cv0.5/58/) | [v1.52.0_cv0.5.58](http://phenomenal-h2020.eu/jenkins/job/container-xcms/) | Kristian Peters | IPB Halle | |


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
helm install galaxy-helm-repo/galaxy
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
