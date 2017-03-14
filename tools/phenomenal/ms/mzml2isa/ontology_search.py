#!/usr/bin/python
import os
import csv
import inspect


def getNames(source="role"):


    filename = inspect.getframeinfo(inspect.currentframe()).filename
    path = os.path.dirname(os.path.abspath(filename))


    if source == "role":
        tablepth = os.path.join(path, 'pub_role.loc')
    elif source == "status":
        tablepth = os.path.join(path, 'pub_status.loc')
    else:
        print "Table not recognised"
        return ""

    print tablepth

    with open(tablepth, "rb") as csvfile:
        reader = csv.reader(csvfile, delimiter='\t')
        l = list(reader)

    l = [i + [""] for i in l]

    l.sort(key=lambda x: x[0])

    return l

