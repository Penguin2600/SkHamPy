#############################################
## last updated: Jul, 02 2009
## 
## Charles Bock - Cbock at ASU dot EDU
## 
##############################################

import os, sys
from subprocess import *

filename = r"C:\Python26\python.exe"
doc = r"C:\Documents and Settings\Deacon\Desktop\SkHamPy\call.py"
arg1= r" +18004444444"

try:
    #os.system (filename + " " + doc)
    #os.system ('"%s" "%s" "%s"'  % (filename, doc, arg1))
    retcode = call([filename, doc, arg1])
    if retcode < 0:
        print >>sys.stderr, "Child was terminated by signal", -retcode
    else:
        print >>sys.stderr, "Child returned", retcode
except OSError, e:
    print >>sys.stderr, "Execution failed:", e


