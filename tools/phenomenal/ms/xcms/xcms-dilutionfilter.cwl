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
    dockerPull: payamemami/xcms-container

label: Dilution Filter
doc: |
 Filters out the peaks that do not correlate with a dilution trend.
 Please cite: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org

inputs:
  xcmsset:
    type: File
    format: iana:application/x-r-data
    label: Input RData file
    doc: |
     rdata containing a grouped xcmsSet. This xcmsSet should contain dilution
     samples as well as real samples. The phenotype (class) of the samples
     should also be set using for example find-peaks. Althought there are many
     ways of generating the rdata file, the  the most straightforward pipline
     can for example be like
     xcms-findpeaks->collect->xcms-group->xcms-retcor->dilutionfilter.
  dilution:
    type: string
    label: Class of dilution trends
    doc: |
      IMPORTANT: the samples are correlated to the provided sequence as set
      here. 
  corto:
    type: string
    label: Correlate dilution to this series
    doc: |
      This series will used for calculation of correlation. For example if this
      parameter is set like "1,2,3" and the class of dilution trends is set as
      "D1,D2,D3" the following the pairs will be used for calculating the
      correlation: (D1,1),(D2,2),(D3,3).
  pvaluein:
    type: float
    label: p-value cutoff for dilution trends
    doc: Signals with correlation p-value higher than this will be removed.
  cor:
    type: string
    label: Correlation cutoff for dilution trends
    doc: Signals with lower correlation than this will be removed.
  abs:
    type: string
    label: Absolute correlation (T or F)
    doc: |
      Should the algorithm use the correlation as it is (negative and positive)
      or absolute correlation ?

outputs:
  peaks:
    label: xcms-stable peaks
    doc: A rdata file containing a XCMS-Set with unstable signals removed.
    type: File
    format: iana:application/x-r-data  # FIXME should be a data type specific to xcms? 
    outputBinding:
      glob: output.Rdata

baseCommand: dilutionfilter.r

arguments:
 - input=$(inputs.xcmsset.path)
 - output=output.Rdata
 - Corto=$(inputs.corto)
 - dilution=$(inputs.dilution)
 - pvalue=$(inputs.pvalue)
 - corcut=$(inputs.cor)
 - abs=$(inputs.abs)

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"
