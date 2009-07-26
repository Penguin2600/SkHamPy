##############################################
## last updated: Jul, 02 2009
## 
## Charles Bock - Cbock at ASU dot EDU
## 
##############################################

import re, os, sys, serial, time, pyTTS, datetime # holy shit
from DTMFdetector import DTMFdetector
from pyRecorder import Recorder
from pyRcCmd import Command

    
def Main():
    Wav_File=str(os.path.abspath(os.path.dirname(sys.argv[0])) + "\\temp.wav")
    Rec = Recorder()
    Dtmf = DTMFdetector()
    DtmfChars=""
    
    re1='(CB)'
    re2='(\\d\d\d\d\d\d\d\d\d\d)'	
    rg = re.compile(re1+re2,re.IGNORECASE|re.DOTALL)
    print "Initialized and Ready"
    
    while 1:
        Rec.record(1,Wav_File)
        Data = Dtmf.getDTMFfromWAV(Wav_File)
        DtmfChars+=Data
        txt = DtmfChars
        m = rg.search(txt)
        if m:
            int1=m.group(2)
            print "DTMF: " + DtmfChars
            print "Dialing: " + int1
            cmd = "C:\Documents\ and\ Settings\Deacon\Desktop\SkHamPy\call.py +1" + str(int1)
            os.system(cmd)
            DtmfChars=""

if __name__ == '__main__':

    os.system("cls")
    RcCom = Command()
    Main()












