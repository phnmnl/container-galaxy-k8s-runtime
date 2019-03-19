#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: CAMERA Find Isotopes

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
  max_charge:
    type: int
    label: Max. number of the isotope charge

outputs:
  annotated_isotopes:
    type: File
    format: iana:application/x-r-data
    doc: A rdata file containing one xsAnnotate object 
    outputBinding:
      glob: ouput.Rdata

baseCommand: findIsotopes.r

arguments:
 - input=$(inputs.xs_annotate.path)
 - output=output.Rdata
 - maxcharge=$(inputs.max_charge)

doc: |
  Annotate isotope peaks for a xsAnnotate object. Returns a xsAnnotate object
  with annotated isotopes.
  
  **Please cite**: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org

  **References**
  Kuhl C, Tautenhahn R, Boettcher C, Larson TR and Neumann S (2012). "CAMERA:
  an integrated strategy for compound spectra extraction and annotation of
  liquid chromatography/mass spectrometry data sets." Analytical Chemistry, 84,
  pp. 283-289. http://pubs.acs.org/doi/abs/10.1021/ac202450g. 

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"

