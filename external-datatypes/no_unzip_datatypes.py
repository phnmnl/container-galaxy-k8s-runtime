# -*- coding: utf-8 -*-
"""
no_unzip_datatypes

A perfect clone of the prims masscomb datatype FileSet
"""

import logging
import zipfile 
import os,os.path,re
from galaxy.datatypes.data import *
from galaxy.datatypes.xml import *
from galaxy.datatypes.sniff import *
from galaxy.datatypes.binary import *
from galaxy.datatypes.interval import * 

log = logging.getLogger(__name__)
    

class NoUnzip( Binary ):
    """FileSet containing N files"""
    file_ext = "no_unzip.zip"
    blurb = "(zipped) FileSet containing multiple files"
    
    def sniff( self, filename ):
        # If the zip file contains multiple files then return true, false otherwise: 
        zf = zipfile.ZipFile(filename)
        if (len(zf.infolist())>1):
            return True
        else :
            return False 
    
    
# the if is just for backwards compatibility...could remove this at some point
if hasattr(Binary, 'register_sniffable_binary_format'):
    Binary.register_sniffable_binary_format('NoUnzip', 'no_unzip.zip', NoUnzip) 
    
    
    
    
    
    



