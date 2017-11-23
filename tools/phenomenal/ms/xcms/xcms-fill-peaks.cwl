#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      xcms:
        specs:
          - https://identifiers.org/rrid/RRID:SCR_015538
          - https://bio.tools/xcms
  DockerRequirement:
    dockerPull: biocontainers/xcms

label: XCMS Fill Peaks
doc: |
  For each sample, identify peak groups where that sample is not represented.
  For each of those peak groups, integrate the signal in the region of that
  peak group and create a new peak.

baseCommand: fillPeaks.r

arguments:
 - input=$(inputs.xcms.path)
 - output=output.Rdata

inputs:
  xcms:
    type: File
    label: XCMS-Set file
    format: iana:application/x-r-data 
    doc: |
      A rdata file with XCMS-Set objects that were grouped and pre-processed by
      e.g. xcms-collect-peak and xcms-correct-rt

outputs:
  filled_peaks:
    type: File
    label: A rdata file containing one XCMS-Set of multiple XCMS-Set objects
    format: iana:application/x-r-data
    outputBinding:
      glob: output.Rdata

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"
