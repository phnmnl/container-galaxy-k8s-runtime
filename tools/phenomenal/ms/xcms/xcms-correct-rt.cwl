#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool

hints:
  SoftwareRequirement:
    packages:
      xcms:
        specs: [ https://identifiers.org/rrid/RRID:SCR_015538 ]

label: Correct differences between retention times between different samples using the `retcor` generic method.

inputs:
  peaks:
    type:
      type: array
      items: File
      inputBinding:
        prefix: input=
        separate: false
    format: iana:application/x-r-data
    label: XCMS-Set file
    doc: A rdata file with XCMS-Set objects that were grouped by xcms-collect-peaks

outputs:
  corrected_peaks:
    type: File
    doc: |
      A rdata file containing one XCMS-Set of multiple XCMS-Set objects with
      retention time corrected values
    format: iana:application/x-r-data
    outputBinding:
      glob: output.Rdata

baseCommand: retCor.r

arguments:
  - method=obiwarp  # or loess
  - output=output.Rdata

doc: |
  To correct differences between retention times between different samples, a
  number of of methods exist in XCMS. retcor is the generic method. The module
  gets XCMS-Set objects which was grouped together by **xcms-collect-peaks**
  
  Please cite: R Core Team (2013). R: A language and Environment for
  Statistical Computing. http://www.r-project.org
  
  References: 
  - Smith, C.A., Want, E.J., O'Maille, G., Abagyan,R., Siuzdak and G. (2006).
    "XCMS: Processing mass spectrometry data for metabolite profiling using
    nonlinear peak alignment, matching and identification." Analytical
    Chemistry, 78, pp. 779-787.
  - Tautenhahn R, Boettcher C and Neumann S (2008). "Highly sensitive feature
    detection for high resolution LC/MS." BMC Bioinformatics, 9, pp. 504.
  - Benton HP, Want EJ and Ebbels TMD (2010). "Correction of mass calibration
    gaps in liquid chromatography-mass spectrometry metabolomics data."
    BIOINFORMATICS, 26, pp. 2488.

# Method
# 	| Method to use for retention time correction. There are 2 methods available:
# 
# +---------+-------------------------------------------------------------------------------------------------------------------------+
# | Method  | Description                                                                                                             |
# +=========+=========================================================================================================================+
# | loess   | Fit a polynomial surface determined by one or more numerical predictors, using local fitting.                           |
# +---------+-------------------------------------------------------------------------------------------------------------------------+
# | obiwarp | Calculate retention time deviations for each sample. It is based on the code at http://obi-warp.sourceforge.net/.       |
# |         | However, this function is able to align multiple samples, by a center-star strategy.                                    |
# +---------+-------------------------------------------------------------------------------------------------------------------------+

$namespaces: 
  iana: "https://www.iana.org/assignments/media-types/"
