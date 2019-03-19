#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: CAMERA Find Adducts

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
  ppm:
    type: float
    label: The ppm error for the search
  polarity:
    type: string
    label: Polarity mode used for measuring of the MS sample
    doc: "Allowed values: positive, negative"
  rules:
    type: string
    label: Adduct ruleset to be used
    doc: |
      Allowed values:
       - primary - contains most common adduct types
         ([M-H]-, [M-2H+Na]-, [M-2H+K]-, [M+Cl]-, [M+H]+, [M+Na]+, [M+K]+, [M+NH4]+)
       - extended - next to primary also additional adduct types 

outputs:
  peak_table:
    type: File
    format: iana:application/x-r-data
    doc: A rdata file containing one xsAnnotate object 
    outputBinding:
      glob: ouput.Rdata
  peak_plot:
    type: File
    format: iana:application/pdf
    doc: The plotted pseudo spectra with their adduct annotations
    outputBinding:
      glob: ouput.pdf

baseCommand: findAdducts.r

arguments:
 - input=$(inputs.xs_annotate.path)
 - output=output.Rdata
 - ppm=$(inputs.ppm)
 - polarity=$(inputs.polarity)
 - output.pdf=output.pdf
 - plotpdf=true
 - rules=$(inputs.rules)

doc: |
  Perform precursor adduct annotation using CAMERA. 
  
  Annotate adducts (and fragments) for a xsAnnotate object. Returns a
  xsAnnotate object with annotated pseudospectra. It is recommended to use
  **camera-find-isotopes** beforehand.

  **Please cite**: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org

  **References**
  Kuhl C, Tautenhahn R, Boettcher C, Larson TR and Neumann S (2012). "CAMERA:
  an integrated strategy for compound spectra extraction and annotation of
  liquid chromatography/mass spectrometry data sets." Analytical Chemistry, 84,
  pp. 283-289. http://pubs.acs.org/doi/abs/10.1021/ac202450g. 

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"
