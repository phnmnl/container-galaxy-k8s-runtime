# -*- coding: utf-8 -*-
"""
NmrML datatype

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


class NmrML(ProteomicsXml):
    """NmrML data"""
    edam_format = "format_3244"
    file_ext = "NmrML"
    blurb = 'nmrML Mass Spectrometry data'
    root = "(NmrML|indexednmrML)"


