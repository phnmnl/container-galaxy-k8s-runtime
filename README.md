
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
 | [BATMAN]() | [container-BATMAN](https://github.com/phnmnl/container-BATMAN/releases/tag/v1.2.12.0_cv1.0) | [v1.2.12.0_cv1.0.65](http://phenomenal-h2020.eu/jenkins/job/container-BATMAN/) | Jianliang Gao / Pablo Moreno | Imperial College London, EMBL-EBI | |
 | [bioc_devel_metabolomics]() | [container-bioc_devel_metabolomics](https://github.com/phnmnl/container-bioc_devel_metabolomics/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-bioc_devel_metabolomics/) | Steffen Neumann | IPB Halle | |
 | [bioc_devel_protmetcore]() | [container-bioc_devel_protmetcore](https://github.com/phnmnl/container-bioc_devel_protmetcore/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-bioc_devel_protmetcore/) | Steffen Neumann | IPB Halle | |
 | [Biosigner]() | [container-Biosigner](https://github.com/phnmnl/container-Biosigner/releases/tag/v2.2.7_cv1.1) | [v2.2.7_cv1.1.12](http://phenomenal-h2020.eu/jenkins/job/container-Biosigner/) | Pierrick Roger | CEA | |
 | [CAMERA]() | [container-CAMERA](https://github.com/phnmnl/container-CAMERA/releases/tag/v1.32.0_cv0.5) | [v1.32.0_cv0.5.45](http://phenomenal-h2020.eu/jenkins/job/container-CAMERA/) | Christoph Ruttkies | IPB Halle | |
 | [escher-fluxomics]() | [container-escher-fluxomics](https://github.com/phnmnl/container-escher-fluxomics/releases/tag/v1.6.0-beta.4_cv1.0) | [v1.6.0-beta.4_cv1.0.9](http://phenomenal-h2020.eu/jenkins/job/container-escher-fluxomics/) | Pablo Moreno | EMBL-EBI | |
 | [galaxy-k8s-runtime]() | [container-galaxy-k8s-runtime](https://github.com/phnmnl/container-galaxy-k8s-runtime/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-galaxy-k8s-runtime/) | Pablo Moreno | EMBL-EBI | |
 | [ipo]() | [container-ipo](https://github.com/phnmnl/container-ipo/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-ipo/) | Pablo Moreno, Venkata Chandrasekhar Nainala | EMBL-EBI | |
 | [isajson-validator]() | [container-isajson-validator](https://github.com/phnmnl/container-isajson-validator/releases/tag/v0.8.0_cv0.2.26 **) | [v0.8.0_cv0.2.26 ](http://phenomenal-h2020.eu/jenkins/job/container-isajson-validator/) | David Johnson | U. of Oxford | |
 | [isatab-validator]() | [container-isatab-validator](https://github.com/phnmnl/container-isatab-validator/releases/tag/v0.8.0_cv0.2.16 **) | [v0.8.0_cv0.2.16 ](http://phenomenal-h2020.eu/jenkins/job/container-isatab-validator/) | David Johnson | U. of Oxford | |
 | [isatab2json]() | [container-isatab2json](https://github.com/phnmnl/container-isatab2json/releases/tag/v0.8.0_cv0.2.39 **) | [v0.8.0_cv0.2.39 ](http://phenomenal-h2020.eu/jenkins/job/container-isatab2json/) | David Johnson | U. of Oxford | |
 | [iso2flux]() | [container-iso2flux](https://github.com/phnmnl/container-iso2flux/releases/tag/v0.2_cv1.1) | [v0.2_cv1.1.36](http://phenomenal-h2020.eu/jenkins/job/container-iso2flux/) | Pablo Moreno | EMBL-EBI | |
 | [isodyn]() | [container-isodyn](https://github.com/phnmnl/container-isodyn/releases/tag/v1.0_cv0.2) | [v1.0_cv0.2.30](http://phenomenal-h2020.eu/jenkins/job/container-isodyn/) | Pablo Moreno | EMBL-EBI | |
 | [json2isatab]() | [container-json2isatab](https://github.com/phnmnl/container-json2isatab/releases/tag/v0.8.0_cv0.2.26 **) | [v0.8.0_cv0.2.26 ](http://phenomenal-h2020.eu/jenkins/job/container-json2isatab/) | David Johnson | U. of Oxford | |
 | [jupyter]() | [container-jupyter](https://github.com/phnmnl/container-jupyter/releases/tag/v387f29b6ca83_cv0.4) | [v387f29b6ca83_cv0.4.7](http://phenomenal-h2020.eu/jenkins/job/container-jupyter/) | Marco Capuccini, Pablo Moreno | Uppsala U., EMBL-EBI | |
 | [lcmsmatching]() | [container-lcmsmatching](https://github.com/phnmnl/container-lcmsmatching/releases/tag/v3.1.6_cv1.3) | [v3.1.6_cv1.3.61](http://phenomenal-h2020.eu/jenkins/job/container-lcmsmatching/) | Pierrick Roger | CEA | |
 | [Luigi]() | [container-Luigi](https://github.com/phnmnl/container-Luigi/releases/tag/v2.6.0_cv0.1) | [v2.6.0_cv0.1.5](http://phenomenal-h2020.eu/jenkins/job/container-Luigi/) | Marco Capuccini, Pablo Moreno | Uppsala U., EMBL-EBI | |
 | [Metabolights downloader (scp-aspera)]() | [container-Metabolights downloader (scp-aspera)](https://github.com/phnmnl/container-Metabolights downloader (scp-aspera)/releases/tag/v3.5.4.102989-linux-64_cv0.2) | [v3.5.4.102989-linux-64_cv0.2.9](http://phenomenal-h2020.eu/jenkins/job/container-Metabolights downloader (scp-aspera)/) | Pablo Moreno | EMBL-EBI | |
 | [MetaboliteIDConverter]() | [container-MetaboliteIDConverter](https://github.com/phnmnl/container-MetaboliteIDConverter/releases/tag/v0.5.1_cv1.1) | [v0.5.1_cv1.1.28](http://phenomenal-h2020.eu/jenkins/job/container-MetaboliteIDConverter/) | Benjamin Merlet | INRA | |
 | [metabomatching]() | [container-metabomatching](https://github.com/phnmnl/container-metabomatching/releases/tag/v0.1.0_cv0.3) | [v0.1.0_cv0.3.29](http://phenomenal-h2020.eu/jenkins/job/container-metabomatching/) | Rico Rueedi | U. of Lausanne | |
 | [metfamily]() | [container-metfamily](https://github.com/phnmnl/container-metfamily/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-metfamily/) | Kristian Peters | IPB Halle | |
 | [metfrag-cli]() | [container-metfrag-cli](https://github.com/phnmnl/container-metfrag-cli/releases/tag/v2.4.2_cv0.3) | [v2.4.2_cv0.3.24](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli/) | Christoph Ruttkies | IPB Halle | |
 | [metfrag-cli-batch]() | [container-metfrag-cli-batch](https://github.com/phnmnl/container-metfrag-cli-batch/releases/tag/v2.4.2_cv0.1) | [v2.4.2_cv0.1.12](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli-batch/) | Christoph Ruttkies | IPB Halle | |
 | [metfrag-vis]() | [container-metfrag-vis](https://github.com/phnmnl/container-metfrag-vis/releases/tag/v0.1_cv0.1) | [v0.1_cv0.1.12](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-vis/) | Christoph Ruttkies | IPB Halle | |
 | [midcor]() | [container-midcor](https://github.com/phnmnl/container-midcor/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.39](http://phenomenal-h2020.eu/jenkins/job/container-midcor/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona | |
 | [ms-vfetc]() | [container-ms-vfetc](https://github.com/phnmnl/container-ms-vfetc/releases/tag/v0.4_cv1.3) | [v0.4_cv1.3.10](http://phenomenal-h2020.eu/jenkins/job/container-ms-vfetc/) | Michael van Vliet | Leiden University | |
 | [msnbase]() | [container-msnbase](https://github.com/phnmnl/container-msnbase/releases/tag/v2.0.2_cv0.2) | [v2.0.2_cv0.2.42](http://phenomenal-h2020.eu/jenkins/job/container-msnbase/) | Kristian Peters, Payam Emami | IPB Halle, Uppsala U. | |
 | [mtbl-labs-uploader]() | [container-mtbl-labs-uploader](https://github.com/phnmnl/container-mtbl-labs-uploader/releases/tag/v0.1.0_cv0.3) | [v0.1.0_cv0.3.11](http://phenomenal-h2020.eu/jenkins/job/container-mtbl-labs-uploader/) | Pablo Moreno | EMBL-EBI | |
 | [mtblisa slicer]() | [container-mtblisa slicer](https://github.com/phnmnl/container-mtblisa slicer/releases/tag/v0.8.0_cv0.5) | [v0.8.0_cv0.5.44](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa slicer/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI | |
 | [mtbls-dwnld]() | [container-mtbls-dwnld](https://github.com/phnmnl/container-mtbls-dwnld/releases/tag/v2.0.5_cv1.2) | [v2.0.5_cv1.2.16](http://phenomenal-h2020.eu/jenkins/job/container-mtbls-dwnld/) | Pierrick Roger | CEA | |
 | [mtbls-factors-viz]() | [container-mtbls-factors-viz](https://github.com/phnmnl/container-mtbls-factors-viz/releases/tag/v0.4_cv0.3) | [v0.4_cv0.3.11](http://phenomenal-h2020.eu/jenkins/job/container-mtbls-factors-viz/) | Pablo Moreno | EMBL-EBI | |
 | [Multivariate]() | [container-Multivariate](https://github.com/phnmnl/container-Multivariate/releases/tag/v2.3.10_cv1.1) | [v2.3.10_cv1.1.18](http://phenomenal-h2020.eu/jenkins/job/container-Multivariate/) | Pierrick Roger | CEA | |
 | [mw2isa]() | [container-mw2isa](https://github.com/phnmnl/container-mw2isa/releases/tag/v0.5.0_cv0.1) | [v0.5.0_cv0.1.20](http://phenomenal-h2020.eu/jenkins/job/container-mw2isa/) | Phillipe Rocaserra | U. of Oxford | |
 | [mzML2isa]() | [container-mzML2isa](https://github.com/phnmnl/container-mzML2isa/releases/tag/v0.4.28_cv0.2) | [v0.4.28_cv0.2.23](http://phenomenal-h2020.eu/jenkins/job/container-mzML2isa/) | Pablo Moreno, Thomas Lawson | EMBL-EBI, U. of Birmingham | |
 | [mzml2metfrag]() | [container-mzml2metfrag](https://github.com/phnmnl/container-mzml2metfrag/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-mzml2metfrag/) | Christoph Ruttkies | IPB Halle | |
 | [nmrglue]() | [container-nmrglue](https://github.com/phnmnl/container-nmrglue/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-nmrglue/) | Kristian Peters | IPB Halle | |
 | [nmrML2isa]() | [container-nmrML2isa](https://github.com/phnmnl/container-nmrML2isa/releases/tag/v0.3.0_cv0.1) | [v0.3.0_cv0.1.10](http://phenomenal-h2020.eu/jenkins/job/container-nmrML2isa/) | Pablo Moreno, Thomas Lawson | EMBL-EBI, U. of Birmingham | |
 | [nmrmlconv]() | [container-nmrmlconv](https://github.com/phnmnl/container-nmrmlconv/releases/tag/v1.1b_cv0.4) | [v1.1b_cv0.4.46](http://phenomenal-h2020.eu/jenkins/job/container-nmrmlconv/) | Kristian Peters | IPB Halle | |
 | [nmrpro]() | [container-nmrpro](https://github.com/phnmnl/container-nmrpro/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-nmrpro/) | Kristian Peters | IPB Halle | |
 | [npc2batman]() | [container-npc2batman](https://github.com/phnmnl/container-npc2batman/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-npc2batman/) | Jianliang Gao | Imperial College London | |
 | [openms]() | [container-openms](https://github.com/phnmnl/container-openms/releases/tag/v2.1.0_cv0.2) | [v2.1.0_cv0.2.15](http://phenomenal-h2020.eu/jenkins/job/container-openms/) | Christoph Ruttkies | IPB Halle | |
 | [papy]() | [container-papy](https://github.com/phnmnl/container-papy/releases/tag/v2.0_cv1.0) | [v2.0_cv1.0.25](http://phenomenal-h2020.eu/jenkins/job/container-papy/) | Jianliang Gao | Imperial College London | |
 | [phenomenal-branded-galaxy]() | [container-phenomenal-branded-galaxy](https://github.com/phnmnl/container-phenomenal-branded-galaxy/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-phenomenal-branded-galaxy/) | Sijin He | EMBL-EBI | |
 | [phenomenal-portal]() | [container-phenomenal-portal](https://github.com/phnmnl/container-phenomenal-portal/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-phenomenal-portal/) | Sijin He | EMBL-EBI | |
 | [pwiz]() | [container-pwiz](https://github.com/phnmnl/container-pwiz/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-pwiz/) | Steffen Neumann | IPB Halle | |
 | [ramid]() | [container-ramid](https://github.com/phnmnl/container-ramid/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.14](http://phenomenal-h2020.eu/jenkins/job/container-ramid/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona | |
 | [rbase]() | [container-rbase](https://github.com/phnmnl/container-rbase/releases/tag/v3.4.1-1xenial0_cv0.2) | [v3.4.1-1xenial0_cv0.2.12](http://phenomenal-h2020.eu/jenkins/job/container-rbase/) | Kristian Peters, Pablo Moreno | IPB Halle, EMBL-EBI | |
 | [rNMR]() | [container-rNMR](https://github.com/phnmnl/container-rNMR/releases/tag/v1.1.9_cv0.2) | [v1.1.9_cv0.2.1024](http://phenomenal-h2020.eu/jenkins/job/container-rNMR/) | Kristian Peters | IPB Halle | |
 | [rNMR-1D]() | [container-rNMR-1D](https://github.com/phnmnl/container-rNMR-1D/releases/tag/v1.2.8_cv0.3) | [v1.2.8_cv0.3.22](http://phenomenal-h2020.eu/jenkins/job/container-rNMR-1D/) | Kristian Peters | IPB Halle | |
 | [SOAP-NMR]() | [container-SOAP-NMR](https://github.com/phnmnl/container-SOAP-NMR/releases/tag/v1.0_cv0.4) | [v1.0_cv0.4.1016](http://phenomenal-h2020.eu/jenkins/job/container-SOAP-NMR/) | Kristian Peters | IPB Halle | |
 | [speaq]() | [container-speaq](https://github.com/phnmnl/container-speaq/releases/tag/**) | [](http://phenomenal-h2020.eu/jenkins/job/container-speaq/) | Kristian Peters | IPB Halle | |
 | [Univariate]() | [container-Univariate](https://github.com/phnmnl/container-Univariate/releases/tag/v2.2.3_cv1.2) | [v2.2.3_cv1.2.28](http://phenomenal-h2020.eu/jenkins/job/container-Univariate/) | Pierrick Roger | CEA | |
 | [xcms]() | [container-xcms](https://github.com/phnmnl/container-xcms/releases/tag/v1.52.0_cv0.5) | [v1.52.0_cv0.5.58](http://phenomenal-h2020.eu/jenkins/job/container-xcms/) | Kristian Peters | IPB Halle | |


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
