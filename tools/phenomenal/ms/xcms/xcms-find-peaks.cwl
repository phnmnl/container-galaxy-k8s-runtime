#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

baseCommand: findPeaks.r

hints:
  SoftwareRequirement:
    packages:
      xcms:
        specs:
          - https://identifiers.org/rrid/RRID:SCR_015538
          - https://bio.tools/xcms
  DockerRequirement:
    dockerPull: biocontainers/xcms

inputs:
  spectra:
    type:
      type: array
      items: File
      inputBinding:
        prefix: input=
        separate: false
    format: edam:format_3244 # mzML
    label: A mzML file that includes data from a MS measurement

  ppm:
    type: float
    doc: |
      Maxmial tolerated m/z deviation in consecutive scans, in ppm (parts per
      million)
  peakwidthLow:
    type: float
    doc: Minimum value of chromatographic peak width in seconds
  peakwidthHigh:
    type: float
    doc: Maximum value of chromatographic peak width in seconds
  noise:
    type: float
    doc: |
      Centroids with intensity smaller than this value are omitted from ROI
      detection. Useful for data that was centroided without any intensity
      threshold.
  polarity:
    type: string
    doc: |
      Filter raw data for positive/negative scans. Valid values are "positive",
      and "negative".
  realFileName: string

outputs:
  deconvoluted_peaks:
    type: File
    outputBinding:
      glob: output.Rdata
    doc: A rdata file containing a XCMS-Set generated from the input mzML file

arguments:
 - output=output.Rdata
 - ppm=$(inputs.ppm)
 - peakwidthLow=$(inputs.peakwidthLow)
 - peakwidthHigh=$(inputs.peakwidthHigh)
 - noise=$(inputs.noise)
 - polarity=$(inputs.polarity)
 - realFileName=$(inputs.realFileName)

label: XMCS Find Peaks


$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"
  edam: "http://edamontology.org"

#$schemas:
#  - http://edamontology.org/EDAM_1.19.owl
doc: |
  Find peaks in mzML file and generate a xcmsSet using XCMS centWave algorithm.
  This module handles the construction of XCMS-Set objects from mzML input
  files and finds peaks in batch mode.
 
  **Please cite**: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org
