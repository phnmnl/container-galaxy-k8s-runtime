#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

label: Prepare output for doing multi/uni variate

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
  camera:
    type: File
    format: iana:application/x-r-data 
    label: XCMS-Set file
    doc: This is the quantification results from CAMERA. 
  scores:
    type: File
    format: iana:application/text
    label: Identification results
  phenotypes:
    type: File
    format: iana:text/csv
    label: phenotype and metadata information
    doc: |
      Example of phenotype information:
      The first column of this table must show the raw data file name (for
      example sample1.mzML). The file must have a header. Other information
      can also be added to this table such as age, gender, time etc. This will
      be output as they are.
      
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | RawFile        | Class    | Groups    | Type     | rename     | Technical repl   | Age   | Gender   |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Sample1.mzML   | Sample   | Disease   | keep     | Disease1   | 1                | 35    | M        |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Sample2.mzML   | Sample   | Disease   | keep     | Disease2   | 1                | 35    | M        |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Sample3.mzML   | Sample   | Control   | keep     | Control1   | 2                | 37    | F        |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Sample4.mzML   | Sample   | Control   | keep     | Control2   | 2                | 37    | F        |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Blank1.mzML    | Blank    | NA        | remove   | NA         | NA               | NA    | NA       |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Blank2.mzML    | Blank    | NA        | remove   | NA         | NA               | NA    | NA       |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | Blank3.mzML    | Blank    | NA        | remove   | NA         | NA               | NA    | NA       |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | D1.mzML        | D1       | NA        | remove   | NA         | NA               | NA    | NA       |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | D2.mzML        | D2       | NA        | remove   | NA         | NA               | NA    | NA       |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+
      | D3.mzML        | D3       | NA        | remove   | NA         | NA               | NA    | NA       |
      +----------------+----------+-----------+----------+------------+------------------+-------+----------+


  ppm:
    type: float
    label: PPM tolerance for matching
    doc: |
      m/z tolerance for matching identification results to quantification
      (parts per million)
  rt:
    type: float
    label: RT tolerance for matching
    doc: |
      Retention time tolerance for matching identification results to
      quantification (seconds).
  higher_the_better:
    type: string
    label: Higher the score the better?
    doc: |
      If the higher score represents a better hit. For example,
      FragmenterScore will be higher for reliable hits but q-value will be
      lower. ("true" or "false")
  score_type:
    type: string
    label: which score to use?
    doc: |
      "q.value", "Score" for the Normalized score, or "FragmenterScore"
      Depending on the previous tool used to perform the identification,
      FragmenterScore, Score and q.value can be used. q.value should only be
      selected if the MetFrag scores have been converted to posterior error
      probability score.
  impute:
    type: string
    label: Impute IDs within pc groups?
    doc: |
      "true" or "false"
      Metabolites quantification profile often result in a number signals. One
      some of this signal can be identified. If this parameter is set, the
      unidentified signals will be imputed by the identification based on
      CAMERA grouping.
  rename:
    type: string
    default: "false"
    label: Rename the sample file names to specific names
    doc: |
      "true" or "false". If "true" then the samples will be renamed based on
      information provide in column "rename_column"
  rename_column:
    type: string
    default: renameto
    label: column with the names you want to rename the samples to
  column_type:
    type: string
    default: type
    label: the name of the column showing the samples you want to keep
    doc: |
      The phenotype file must have a column showing which samples to keep and
      which to remve. Enter name of that column.
  selected_type:
    type: string
    default: sample
    label: Which type of samples to keep
    doc: |
      Based on information in "column_type" enter which sample type should be kept.
  only_report_with_id:
    type: string
    default: "false"
    label: Do you want to use the features without ID?
    doc: |
      "true" or "false". If "true" then only identified metabolites will be
      reported.
  combine_replicate:
    type: string
    default: "false"
    label: Do you want to median technial replicates?
    doc: |
      "true" or "false". If "true" then the technical replicates (duplicate
      injections) will be medianed. This information should be provided in an
      additional column in the phenotype information.
  log:
    type: string
    label: Do you want to perform log2 transformation?
    doc: '"true" or "false"'
  combine_replicate_column:
    type: string
    default: rep
    label: Column that represents the technical replicates.
    doc: The column name indicating technical replicate in the phenotype file.
  sample_coverage:
    type: float
    default: 0.0
    label: Percentage of non-missing values
    doc: How much of non-missing value should be present for each feature. 
  sample_coverage_method:
    type: string
    default: global
    doc: |
      Do you want to apply coverage globally across all the runs or per group?
      For applying globally use "global" otherwise write name of the column
      showing the grouping.

outputs:
  peaktable:
    type: File
    format: iana:text/tab-separated-values
    label: A tabular peak table containing abundances
    outputBinding:
      glob: peak_table.tsv
  variables:
    type: File
    format: iana:text/tab-separated-values
    label: Variable data containing identification.
    doc: |
      Aggregated identification results either from metfragaggregator or pep
      score generator
    outputBinding:
      glob: variables.tsv
  metadata:
    type: File
    format: iana:text/tab-separated-values
    label: Sample metadata
    outputBinding:
      glob: metadata.tsv

baseCommand: prepareOutput.r

arguments:
 - inputcamera=$(inputs.camera.path)
 - inputscores=$(input.scores.path)
 - inputpheno=$(input.phenotypes.path)
 - ppm=$(inputs.ppm)
 - rt=$(inputs.rt)
 - higherTheBetter=$(inputs.higher_the_better)
 - scoreColumn=$(inputs.score_type)
 - impute=$(inputs.impute)
 - typeColumn=$(inputs.column_type)
 - selectedType=$(inputs.selected_type)
 - rename=$(inputs.rename)
 - renameCol=$(inputs.rename_column)
 - onlyReportWithID=$(inputs.only_report_with_ID)
 - combineReplicate=$(inputs.combine_replicate)
 - combineReplicateColumn=$(inputs.combine_replicate_column)
 - outputPeakTable=peak_table.tsv
 - outputVariables=variables.tsv
 - outputMetaData=metadata.tsv
 - log=$(inputs.log)
 - sampleCoverage=$(inputs.sample_coverage)
 - sampleCoverageMethod=$(inputs.sample_coverage_method)
 
doc: |
  Converts the quantification and identification results to tabular files for
  multivariate and univariate data analysis

  **Please cite**: 
  R Core Team (2013). R: A language and Environment for Statistical Computing. http://www.r-project.org

  **References**
  Kuhl C, Tautenhahn R, Boettcher C, Larson TR and Neumann S (2012). "CAMERA:
  an integrated strategy for compound spectra extraction and annotation of
  liquid chromatography/mass spectrometry data sets." Analytical Chemistry, 84,
  pp. 283-289. http://pubs.acs.org/doi/abs/10.1021/ac202450g.

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/" 

