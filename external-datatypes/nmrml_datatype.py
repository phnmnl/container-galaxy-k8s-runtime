# -*- coding: utf-8 -*-
"""
nmrML datatype

"""

import logging
import os.path,re
from galaxy.datatypes.data import *
from galaxy.datatypes.sniff import *
from galaxy.datatypes.binary import *
from galaxy.datatypes.tabular import *
from galaxy.datatypes.xml import *
from galaxy.datatypes.proteomics import *

log = logging.getLogger(__name__)


class MzML(ProteomicsXml):
    """nmrML data"""
    edam_format = "format_3244"
    file_ext = "nmrml"
    blurb = 'nmrML Mass Spectrometry data'
    root = "(nmrML|indexednmrML)"


