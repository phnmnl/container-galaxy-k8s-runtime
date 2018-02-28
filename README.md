
![Logo](logo.png)

# Galaxy
Version: 17.09-pheno 

## Short Description

Galaxy is an open, web-based platform for data intensive biomedical research.

## Description
Increased reliance on computational approaches in the life sciences has revealed grave concerns about how accessible and reproducible computation-reliant results truly are. Galaxy http://usegalaxy.org, an open web-based platform for genomic research, addresses these problems. Galaxy automatically tracks and manages data provenance and provides support for capturing the context and intent of computational methods. Galaxy Pages are interactive, web-based documents that provide users with a medium to communicate a complete computational analysis.

This PhenoMeNal version of Galaxy is a container capable of running inside the Kubernetes container orchestrator, and able to schedule Kubernetes jobs from the inside of the cluster. It is a lighweight container as no toolshed dependencies are needed. The current version includes on top of Galaxy 17.09 PhenoMeNal additions to the Galaxy code base:

- Ability to limit resources per tools (CPU and RAM).
- ISA-tab and ISA-json native Composite datatype support in Galaxy.

The Galaxy - Kubernetes integration and Galaxy helm charts are contributions made entirely by the PhenoMeNal Project to the Galaxy Project.

This release version uses the following tools, tagged at these release versions:

| Tool | Container | Tag | Maintainer | Affiliation |
|------|-----------|-----|------------|-------------|
| [batch_correction](https://github.com/phnmnl/container-batch_correction) | [container-batch_correction](https://github.com/phnmnl/container-batch_correction/releases/tag/vphenomenal_2018_02_22_cv0.3) | [vphenomenal_2018_02_22_cv0.3.7](http://phenomenal-h2020.eu/jenkins/job/container-batch_correction/7/) | Pierrick Roger, Nils Paulh | CEA |
| [BATMAN](https://github.com/phnmnl/container-batman) | [container-BATMAN](https://github.com/phnmnl/container-batman/releases/tag/v1.2.12.0_cv1.0) | [v1.2.12.0_cv1.0.65](http://phenomenal-h2020.eu/jenkins/job/container-BATMAN/65/) | Jianliang Gao / Pablo Moreno | Imperial College London, EMBL-EBI |
| [Biosigner](https://github.com/phnmnl/container-biosigner) | [container-Biosigner](https://github.com/phnmnl/container-biosigner/releases/tag/v2.2.7_cv1.3) | [v2.2.7_cv1.3.15](http://phenomenal-h2020.eu/jenkins/job/container-Biosigner/15/) | Pierrick Roger | CEA |
| [bruker2batman](https://github.com/phnmnl/container-bruker2batman) | [container-bruker2batman](https://github.com/phnmnl/container-bruker2batman/releases/tag/Not found) | [Not found](http://phenomenal-h2020.eu/jenkins/job/container-bruker2batman/Not found/) | Vagelis Handakas | Imperial College London |
| [CAMERA](https://github.com/phnmnl/container-camera) | [container-CAMERA](https://github.com/phnmnl/container-camera/releases/tag/v1.33.3_cv0.10) | [v1.33.3_cv0.10.59](http://phenomenal-h2020.eu/jenkins/job/container-CAMERA/59/) | Christoph Ruttkies | IPB Halle |
| [cdf2mid](https://github.com/phnmnl/container-cdf2mid) | [container-cdf2mid](https://github.com/phnmnl/container-cdf2mid/releases/tag/v1.0_cv0.3) | [v1.0_cv0.3.7](http://phenomenal-h2020.eu/jenkins/job/container-cdf2mid/7/) | Vitaly Selivanov | U. Barcelona |
| [escher-fluxomics](https://github.com/phnmnl/container-escher-fluxomics) | [container-escher-fluxomics](https://github.com/phnmnl/container-escher-fluxomics/releases/tag/v1.6.0-beta.4_cv1.0) | [v1.6.0-beta.4_cv1.0.9](http://phenomenal-h2020.eu/jenkins/job/container-escher-fluxomics/9/) | Pablo Moreno | EMBL-EBI |
| [galaxy-k8s-runtime](https://github.com/phnmnl/container-galaxy-k8s-runtime) | [container-galaxy-k8s-runtime](https://github.com/phnmnl/container-galaxy-k8s-runtime/releases/tag/#N/A) | [#N/A](http://phenomenal-h2020.eu/jenkins/job/container-galaxy-k8s-runtime/#N/A/) | Pablo Moreno | EMBL-EBI |
| [isa2w4m](https://github.com/phnmnl/container-isa2w4m) | [container-isa2w4m](https://github.com/phnmnl/container-isa2w4m/releases/tag/v1.1.0_cv1.4) | [v1.1.0_cv1.4.11](http://phenomenal-h2020.eu/jenkins/job/container-isa2w4m/11/) | Pierrick Roger | CEA |
| [isajson-validator](https://github.com/phnmnl/container-isajson-validator) | [container-isajson-validator](https://github.com/phnmnl/container-isajson-validator/releases/tag/Not found) | [Not found](http://phenomenal-h2020.eu/jenkins/job/container-isajson-validator/Not found/) | David Johnson | U. of Oxford |
| [isatab-validator](https://github.com/phnmnl/container-isatab-validator) | [container-isatab-validator](https://github.com/phnmnl/container-isatab-validator/releases/tag/v0.9.4_cv0.4) | [v0.9.4_cv0.4.31](http://phenomenal-h2020.eu/jenkins/job/container-isatab-validator/31/) | David Johnson | U. of Oxford |
| [isatab2json](https://github.com/phnmnl/container-isatab2json) | [container-isatab2json](https://github.com/phnmnl/container-isatab2json/releases/tag/v0.9.4_cv0.5) | [v0.9.4_cv0.5.55](http://phenomenal-h2020.eu/jenkins/job/container-isatab2json/55/) | David Johnson | U. of Oxford |
| [iso2flux](https://github.com/phnmnl/container-iso2flux) | [container-iso2flux](https://github.com/phnmnl/container-iso2flux/releases/tag/v0.6.1_cv2.1) | [v0.6.1_cv2.1.47](http://phenomenal-h2020.eu/jenkins/job/container-iso2flux/47/) | Pablo Moreno, Pedro Atauri | EMBL-EBI, U. of Barcelona |
| [isodyn](https://github.com/phnmnl/container-isodyn) | [container-isodyn](https://github.com/phnmnl/container-isodyn/releases/tag/v1.0_cv0.2) | [v1.0_cv0.2.30](http://phenomenal-h2020.eu/jenkins/job/container-isodyn/30/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona |
| [json2isatab](https://github.com/phnmnl/container-json2isatab) | [container-json2isatab](https://github.com/phnmnl/container-json2isatab/releases/tag/Not found) | [Not found](http://phenomenal-h2020.eu/jenkins/job/container-json2isatab/Not found/) | David Johnson | U. of Oxford |
| [jupyter](https://github.com/phnmnl/container-jupyter) | [container-jupyter](https://github.com/phnmnl/container-jupyter/releases/tag/#N/A) | [#N/A](http://phenomenal-h2020.eu/jenkins/job/container-jupyter/#N/A/) | Marco Capuccini, Pablo Moreno | Uppsala U., EMBL-EBI |
| [lcmsmatching](https://github.com/phnmnl/container-lcmsmatching) | [container-lcmsmatching](https://github.com/phnmnl/container-lcmsmatching/releases/tag/v3.4.3_cv1.5) | [v3.4.3_cv1.5.69](http://phenomenal-h2020.eu/jenkins/job/container-lcmsmatching/69/) | Pierrick Roger | CEA |
| [Luigi](https://github.com/phnmnl/container-luigi) | [container-Luigi](https://github.com/phnmnl/container-luigi/releases/tag/#N/A) | [#N/A](http://phenomenal-h2020.eu/jenkins/job/container-Luigi/#N/A/) | Marco Capuccini, Pablo Moreno | Uppsala U., EMBL-EBI |
| [metabolab](https://github.com/phnmnl/container-metabolab) | [container-metabolab](https://github.com/phnmnl/container-metabolab/releases/tag/v2018.01171502_cv0.1) | [v2018.01171502_cv0.1.84](http://phenomenal-h2020.eu/jenkins/job/container-metabolab/84/) | Michelle Thompson | U. of Birmingham |
| [MetaboliteIDConverter](https://github.com/phnmnl/container-metaboliteidconverter) | [container-MetaboliteIDConverter](https://github.com/phnmnl/container-metaboliteidconverter/releases/tag/v0.5.1_cv1.1) | [v0.5.1_cv1.1.28](http://phenomenal-h2020.eu/jenkins/job/container-MetaboliteIDConverter/28/) | Benjamin Merlet | INRA |
| [metabomatching](https://github.com/phnmnl/container-metabomatching) | [container-metabomatching](https://github.com/phnmnl/container-metabomatching/releases/tag/v0.2.0_cv0.4) | [v0.2.0_cv0.4.62](http://phenomenal-h2020.eu/jenkins/job/container-metabomatching/62/) | Rico Rueedi | U. of Lausanne |
| [metfrag-cli](https://github.com/phnmnl/container-metfrag-cli) | [container-metfrag-cli](https://github.com/phnmnl/container-metfrag-cli/releases/tag/v2.4.2_cv0.3) | [v2.4.2_cv0.3.24](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli/24/) | Christoph Ruttkies | IPB Halle |
| [metfrag-cli-batch](https://github.com/phnmnl/container-metfrag-cli-batch) | [container-metfrag-cli-batch](https://github.com/phnmnl/container-metfrag-cli-batch/releases/tag/v2.4.3_cv0.5) | [v2.4.3_cv0.5.49](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-cli-batch/49/) | Christoph Ruttkies | IPB Halle |
| [metfrag-vis](https://github.com/phnmnl/container-metfrag-vis) | [container-metfrag-vis](https://github.com/phnmnl/container-metfrag-vis/releases/tag/v0.1_cv0.1) | [v0.1_cv0.1.12](http://phenomenal-h2020.eu/jenkins/job/container-metfrag-vis/12/) | Christoph Ruttkies | IPB Halle |
| [midcor](https://github.com/phnmnl/container-midcor) | [container-midcor](https://github.com/phnmnl/container-midcor/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.40](http://phenomenal-h2020.eu/jenkins/job/container-midcor/40/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona |
| [ms-vfetc](https://github.com/phnmnl/container-ms-vfetc) | [container-ms-vfetc](https://github.com/phnmnl/container-ms-vfetc/releases/tag/v0.4_cv1.3) | [v0.4_cv1.3.10](http://phenomenal-h2020.eu/jenkins/job/container-ms-vfetc/10/) | Michael van Vliet | Leiden University |
| [msnbase](https://github.com/phnmnl/container-msnbase) | [container-msnbase](https://github.com/phnmnl/container-msnbase/releases/tag/v2.2_cv0.7) | [v2.2_cv0.7.54](http://phenomenal-h2020.eu/jenkins/job/container-msnbase/54/) | Kristian Peters, Payam Emami | IPB Halle, Uppsala U. |
| [mtbl-labs-uploader](https://github.com/phnmnl/container-mtbl-labs-uploader) | [container-mtbl-labs-uploader](https://github.com/phnmnl/container-mtbl-labs-uploader/releases/tag/v0.1.0_cv0.3) | [v0.1.0_cv0.3.11](http://phenomenal-h2020.eu/jenkins/job/container-mtbl-labs-uploader/11/) | Pablo Moreno | EMBL-EBI |
| [mtblisa](https://github.com/phnmnl/container-mtblisa) | [container-mtblisa](https://github.com/phnmnl/container-mtblisa/releases/tag/v0.9.4_cv0.6.1) | [v0.9.4_cv0.6.1.59](http://phenomenal-h2020.eu/jenkins/job/container-mtblisa/59/) | David Johnson, Pablo Moreno | U. of Oxford, EMBL-EBI |
| [mtbls-dwnld](https://github.com/phnmnl/container-mtbls-dwnld) | [container-mtbls-dwnld](https://github.com/phnmnl/container-mtbls-dwnld/releases/tag/v3.1.0_cv1.3) | [v3.1.0_cv1.3.23](http://phenomenal-h2020.eu/jenkins/job/container-mtbls-dwnld/23/) | Pierrick Roger | CEA |
| [mtbls-factors-viz](https://github.com/phnmnl/container-mtbls-factors-viz) | [container-mtbls-factors-viz](https://github.com/phnmnl/container-mtbls-factors-viz/releases/tag/v0.4_cv0.3) | [v0.4_cv0.3.11](http://phenomenal-h2020.eu/jenkins/job/container-mtbls-factors-viz/11/) | Pablo Moreno | EMBL-EBI |
| [Multivariate](https://github.com/phnmnl/container-multivariate) | [container-Multivariate](https://github.com/phnmnl/container-multivariate/releases/tag/v2.3.10_cv1.2) | [v2.3.10_cv1.2.20](http://phenomenal-h2020.eu/jenkins/job/container-Multivariate/20/) | Pierrick Roger | CEA |
| [mw2isa](https://github.com/phnmnl/container-mw2isa) | [container-mw2isa](https://github.com/phnmnl/container-mw2isa/releases/tag/v0.5.0_cv0.1) | [v0.5.0_cv0.1.20](http://phenomenal-h2020.eu/jenkins/job/container-mw2isa/20/) | Phillipe Rocca-Serra | U. of Oxford |
| [mzML2isa](https://github.com/phnmnl/container-mzml2isa) | [container-mzML2isa](https://github.com/phnmnl/container-mzml2isa/releases/tag/v0.4.28_cv0.2) | [v0.4.28_cv0.2.23](http://phenomenal-h2020.eu/jenkins/job/container-mzML2isa/23/) | Pablo Moreno, Thomas Lawson | EMBL-EBI, U. of Birmingham |
| [nmrML2BATMAN](https://github.com/phnmnl/container-nmrml2batman) | [container-nmrML2BATMAN](https://github.com/phnmnl/container-nmrml2batman/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.4](http://phenomenal-h2020.eu/jenkins/job/container-nmrML2BATMAN/4/) | Vagelis Handakas | Imperial College London, EMBL-EBI |
| [nmrML2isa](https://github.com/phnmnl/container-nmrml2isa) | [container-nmrML2isa](https://github.com/phnmnl/container-nmrml2isa/releases/tag/v0.3.0_cv0.1) | [v0.3.0_cv0.1.10](http://phenomenal-h2020.eu/jenkins/job/container-nmrML2isa/10/) | Pablo Moreno, Thomas Lawson | EMBL-EBI, U. of Birmingham |
| [nmrmlconv](https://github.com/phnmnl/container-nmrmlconv) | [container-nmrmlconv](https://github.com/phnmnl/container-nmrmlconv/releases/tag/v1.1b_cv0.4) | [v1.1b_cv0.4.46](http://phenomenal-h2020.eu/jenkins/job/container-nmrmlconv/46/) | Kristian Peters | IPB Halle |
| [normalization](https://github.com/phnmnl/container-normalization) | [container-normalization](https://github.com/phnmnl/container-normalization/releases/tag/v1.0.6_cv1.1) | [v1.0.6_cv1.1.2](http://phenomenal-h2020.eu/jenkins/job/container-normalization/2/) | Pierrick Roger, Nils Paulh | CEA |
| [openms](https://github.com/phnmnl/container-openms) | [container-openms](https://github.com/phnmnl/container-openms/releases/tag/v2.1.0_cv0.2) | [v2.1.0_cv0.2.15](http://phenomenal-h2020.eu/jenkins/job/container-openms/15/) | Christoph Ruttkies | IPB Halle |
| [papy](https://github.com/phnmnl/container-papy) | [container-papy](https://github.com/phnmnl/container-papy/releases/tag/v2.0_cv1.0) | [v2.0_cv1.0.25](http://phenomenal-h2020.eu/jenkins/job/container-papy/25/) | Jianliang Gao | Imperial College London |
| [passatutto](https://github.com/phnmnl/container-passatutto) | [container-passatutto](https://github.com/phnmnl/container-passatutto/releases/tag/v201604_cv0.1) | [v201604_cv0.1.8](http://phenomenal-h2020.eu/jenkins/job/container-passatutto/8/) | Payam Emami | Uppsala U. |
| [pathwayEnrichment](https://github.com/phnmnl/container-pathwayenrichment) | [container-pathwayEnrichment](https://github.com/phnmnl/container-pathwayenrichment/releases/tag/v1.0.6_cv1.0.5) | [v1.0.6_cv1.0.5.19](http://phenomenal-h2020.eu/jenkins/job/container-pathwayEnrichment/19/) | Ettiene Camenem | INRA |
| [phenomenal-portal](https://github.com/phnmnl/container-phenomenal-portal) | [container-phenomenal-portal](https://github.com/phnmnl/container-phenomenal-portal/releases/tag/#N/A) | [#N/A](http://phenomenal-h2020.eu/jenkins/job/container-phenomenal-portal/#N/A/) | Sijin He | EMBL-EBI |
| [qualitymetrics](https://github.com/phnmnl/container-qualitymetrics) | [container-qualitymetrics](https://github.com/phnmnl/container-qualitymetrics/releases/tag/vphenomenal_2018.02.20_2_cv0.2) | [vphenomenal_2018.02.20_2_cv0.2.6](http://phenomenal-h2020.eu/jenkins/job/container-qualitymetrics/6/) | Pierrick Roger, Nils Paulh | W4M |
| [ramid](https://github.com/phnmnl/container-ramid) | [container-ramid](https://github.com/phnmnl/container-ramid/releases/tag/v1.0_cv1.0) | [v1.0_cv1.0.14](http://phenomenal-h2020.eu/jenkins/job/container-ramid/14/) | Pablo Moreno, Vitaly Selivanov | EMBL-EBI, U. of Barcelona |
| [rbase](https://github.com/phnmnl/container-rbase) | [container-rbase](https://github.com/phnmnl/container-rbase/releases/tag/#N/A) | [#N/A](http://phenomenal-h2020.eu/jenkins/job/container-rbase/#N/A/) | Kristian Peters, Pablo Moreno | IPB Halle, EMBL-EBI |
| [rnmr1d](https://github.com/phnmnl/container-rnmr1d) | [container-rnmr1d](https://github.com/phnmnl/container-rnmr1d/releases/tag/dev_v1.2.8_cv0.4) | [dev_v1.2.8_cv0.4.34](http://phenomenal-h2020.eu/jenkins/job/container-rnmr1d/34/) | Kristian Peters | IPB Halle |
| [scp-aspera](https://github.com/phnmnl/container-scp-aspera) | [container-scp-aspera](https://github.com/phnmnl/container-scp-aspera/releases/tag/v3.5.4.102989-linux-64_cv0.2) | [v3.5.4.102989-linux-64_cv0.2.9](http://phenomenal-h2020.eu/jenkins/job/container-scp-aspera/9/) | Pablo Moreno | EMBL-EBI |
| [speaq](https://github.com/phnmnl/container-speaq) | [container-speaq](https://github.com/phnmnl/container-speaq/releases/tag/Not found) | [Not found](http://phenomenal-h2020.eu/jenkins/job/container-speaq/Not found/) | Kristian Peters | IPB Halle |
| [tool-generic_filter](https://github.com/phnmnl/container-tool-generic_filter) | [container-tool-generic_filter](https://github.com/phnmnl/container-tool-generic_filter/releases/tag/vphenomenal_2017.12.12_cv0.2) | [vphenomenal_2017.12.12_cv0.2.2](http://phenomenal-h2020.eu/jenkins/job/container-tool-generic_filter/2/) | Pierrick Roger, Nils Paulh | W4M |
| [transformation](https://github.com/phnmnl/container-transformation) | [container-transformation](https://github.com/phnmnl/container-transformation/releases/tag/v2.2.2_cv1.2) | [v2.2.2_cv1.2.7](http://phenomenal-h2020.eu/jenkins/job/container-transformation/7/) | Pierrick Roger | CEA |
| [Univariate](https://github.com/phnmnl/container-univariate) | [container-Univariate](https://github.com/phnmnl/container-univariate/releases/tag/v2.2.3_cv1.3) | [v2.2.3_cv1.3.29](http://phenomenal-h2020.eu/jenkins/job/container-Univariate/29/) | Pierrick Roger | CEA |
| [xcms](https://github.com/phnmnl/container-xcms) | [container-xcms](https://github.com/phnmnl/container-xcms/releases/tag/v3.0.0_cv0.1) | [v3.0.0_cv0.1.76](http://phenomenal-h2020.eu/jenkins/job/container-xcms/76/) | Kristian Peters | IPB Halle |
| [xcms-1.x](https://github.com/phnmnl/container-xcms-1.x) | [container-xcms-1.x](https://github.com/phnmnl/container-xcms-1.x/releases/tag/v1.52.0_cv0.9) | [v1.52.0_cv0.9.2](http://phenomenal-h2020.eu/jenkins/job/container-xcms-1.x/2/) | Kristian Peters | IPB Halle |
| [dimspy](https://github.com/phnmnl/container-dimspy) | [container-dimspy](https://github.com/phnmnl/container-dimspy/releases/tag/Not found) | [Not found](http://phenomenal-h2020.eu/jenkins/job/container-dimspy/Not found/) | Ralf Weber, James Bradbury | UoB |



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
