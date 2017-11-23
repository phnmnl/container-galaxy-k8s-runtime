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

label: Filters out the peaks that have higher intensities in blank samples compared to selected samples.

inputs:
  xcmsset:
    type: File
    format: iana:application/x-r-data  # FIXME should be a data type specific to xcms?
    label: Input RData file
    doc: |
      rdata containing a grouped xcmsSet. This xcmsSet should contain dilution
      samples as well as real samples. The phenotype (class) of the samples
      should also be set using for example find-peaks. Althought there are many
      ways of generating the rdata file, the most straightforward pipline
      can for example be like xcms-findpeaks->collect->xcms-group->xcms-retcor->dilutionfilter.
  blank:
    type: string
    label: Class name of the blank samples in the xcmsset
    doc: "IMPORTANT: this class should be identical for all the blank samples."

outputs:
  filtered:
    type: File
    label: xcms-blank filtered out
    doc: A rdata file containing a XCMS-Set with non-biological signals removed.
    format: iana:application/x-r-data
    outputBinding:
      glob: output.Rdata

baseCommand: blankfilter.r

arguments:
 - input=$(inputs.xcmsset.path)
 - output=output.Rdata
 - method=median
 - blank=$(inputs.blank)
 - rest=T

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"

doc: |
  Please cite: R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org
