#!/usr/bin/env python
# vi: fdm=marker

import argparse
import urllib2
import re

# Get assay files {{{1
################################################################

def get_assay_files(study):
    
    # Get study web page content
    response = urllib2.urlopen('http://www.ebi.ac.uk/metabolights/' + study)
    html = response.read()
    
    # Look for assay file names
    assay_files = re.findall('a_[^\'"]*\.txt', html)
    
    # Sort and remove duplicates
    assay_files = sorted(set(assay_files))
 
    # Build table
    table = []
    for i, a in enumerate(assay_files):
        table.append( (a, a, i == 0) )

    return table

# Main {{{1
################################################################

if __name__ == '__main__':
    
    # Parse command line arguments
    parser = argparse.ArgumentParser(description='Script for getting chromatographic columns of an RMSDB database for Galaxy tool lcmsmatching.')
    parser.add_argument('-s', help = 'Metabolight study',   dest = 'study',    required = True)
    args = parser.parse_args()
    args_dict = vars(args)
    
    print(get_assay_files(**args_dict))
