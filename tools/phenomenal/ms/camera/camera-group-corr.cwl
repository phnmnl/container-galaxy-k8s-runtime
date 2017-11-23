#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: CAMERA Group Corr

hints:
  DockerRequirement:
    dockerPull: container-registry.phenomenal-h2020.eu/phnmnl/camera
  SoftwareRequirement:
    packages:
      camera:
        specs:
          - https://bio.tools/camera
          - https://identifiers.org/rrid/RRID:SCR_002466
     
inputs:
  xs_annotate:
    type: File
    format: iana:application/x-r-data
    label: xsAnnotate file
    doc: A rdata file with a xsAnnotate object from one sample
  correlation:
    type: float
    label: The correlation threshold for EIC correlation
  p_value:
    type: float
    label: The p-value threshold for testing correlation of significance

outputs:
  grouped_peaks:
    type: File
    format: iana:application/x-r-data
    doc: |
      a rData file containing one xsAnnotate object containing grouped peaks in
      so called pseudospectra
    outputBinding:
      glob: ouput.Rdata

baseCommand: groupCorr.r

arguments:
 - input=$(inputs.xs_annotate.path)
 - output=output.Rdata
 - correlations=$(inputs.correlation)
 - pvalue=$(inputs.pvalue)

doc: |
  Peak grouping after correlation information into pseudospectrum
  groups for an xsAnnotate object.  

  **Please cite**: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org

  **References**
  Kuhl C, Tautenhahn R, Boettcher C, Larson TR and Neumann S (2012). "CAMERA:
  an integrated strategy for compound spectra extraction and annotation of
  liquid chromatography/mass spectrometry data sets." Analytical Chemistry, 84,
  pp. 283-289. http://pubs.acs.org/doi/abs/10.1021/ac202450g. 

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"

