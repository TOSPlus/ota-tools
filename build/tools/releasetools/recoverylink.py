#!/usr/bin/python
import os
import sys
import re

path = sys.argv[1]
linkfile_path = path + '/SYSTEM/linkinfo.txt'

system_p = re.compile('^system/')

try:
    file_object = open(linkfile_path)
    linelist = file_object.read( ).split()
    for line in linelist:
        line = line.rstrip()
        filepath = line.split('|')
        if system_p.search(filepath[0]):
            filepath[0] = filepath[0].replace('system', 'SYSTEM', 1)
        rm = 'rm -f ' + path+ '/' + filepath[0]
        os.popen(rm)
        dirname=os.path.dirname(filepath[0])
        filepath[0] = os.path.basename(filepath[0])
        if not filepath[1].startswith('/'):
            filepath[1] = os.path.basename(filepath[1])
        ln = 'mkdir -p ' + path + '/' + dirname + ';' + 'cd ' + path + '/' + dirname + ';' + 'ln -s ' + filepath[1] + ' ' +  filepath[0]
        os.popen(ln)
except IOError:
    print r"%s isn't exist" % linkfile_path
    sys.exit(1)

file_object.close( )
print r"Recovery link files success"
sys.exit(0)
