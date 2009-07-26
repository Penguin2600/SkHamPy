##############################################
## last updated: Dec, 12 2008
## 
## Charles Bock - Cbock at ASU dot EDU
## 
##############################################

import os, sys, serial, time

class Command(object):
    def __init__(self):
        
        self.ser = None
        
        print "Finding Tranciever Link Please Wait..."
        Port=self.Connect()    
        if Port=="Fail":
            os.system("cls")
            print "Connect failed! Check Tranciever Link..."
            sys.exit(0)
        else:
            print "Tranciever Link Established COM:"+str(Port)
            Resp=self.Get_Serial()#clear recv buffer

    def Send_Serial(self,val):
        if self.ser.isOpen=="False":
            self.ser.open()
        serstring=str(val)
        self.ser.write(serstring)
        
    def Get_Serial(self):
        if self.ser.isOpen=="False":
            self.ser.open()
        line = str(self.ser.read(6))
        return line[0:5] # dont send back the carrage return, no need

    def Connect(self):
        for i in range(0, 11):
            try:
                print "Probing COM:" + str(i)
                self.ser = serial.Serial(i,9600, timeout=2)
                self.Send_Serial("!")
                if self.Get_Serial()=="COMOK":
                    return i
                    break
            except:
                if i>=10 or i=="None":
                    return "Fail"
                    break
                pass

    def DoCommand(self,Data):
            print "Sending: " + Data
            self.Send_Serial(Data)
            Resp=self.Get_Serial()
            print "Response: " + Resp
            

if __name__ == '__main__':

    print "Wanker"
