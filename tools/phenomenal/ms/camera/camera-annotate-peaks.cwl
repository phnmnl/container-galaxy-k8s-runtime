#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: CAMERA Annotate Peaks

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
  camera_annotate_peaks:
    type: File
    format: iana:application/x-r-data 
    label: XCMS-Set file
    doc: A rdata file with a XCMS-Set object from one sample

outputs:
  peaktable:
    type: File
    format: 
    doc: A rdata file containing one xsAnnotate object 
    outputBinding:
      glob: ouput.Rdata

baseCommand: xsAnnotate.r

arguments:
 - input=$(inputs.camera_annotate_peaks.path)
 - output=output.Rdata

doc: |
  Generate xsAnnotate object used for further CAMERA processing

  This module deals with the construction of an xsAnnotate object. It extracts
  the peaktable from a provided XCMS-Set, which is used for all further
  analysis. Multiple XCMS-Set objects which were grouped by
  **xcms-collect-peaks** need to be split by **xcmssplit** beforehand.

  **Please cite**: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org

  **References**
  Kuhl C, Tautenhahn R, Boettcher C, Larson TR and Neumann S (2012). "CAMERA:
  an integrated strategy for compound spectra extraction and annotation of
  liquid chromatography/mass spectrometry data sets." Analytical Chemistry, 84,
  pp. 283-289. http://pubs.acs.org/doi/abs/10.1021/ac202450g.

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/" 
