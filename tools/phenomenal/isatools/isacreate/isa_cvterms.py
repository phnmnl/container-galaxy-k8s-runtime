#!/usr/bin/python
import os
import inspect
import json


def get_terms(k):
    filename = inspect.getframeinfo(inspect.currentframe()).filename
    path = os.path.dirname(os.path.abspath(filename))
    with open(os.path.join(path, 'isa_cvterms.json')) as fp:
        cvterms = json.load(fp)
    v = [(v, v, False) for v in sorted(cvterms.get(k, []), key=lambda x:x[0])]
    return v
