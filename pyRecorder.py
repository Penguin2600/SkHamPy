import pyaudio
##############################################
## last updated: Dec, 12 2008
## 
## Charles Bock - Cbock at ASU dot EDU
## 
##############################################

import wave
import sys

class Recorder(object):

    def __init__(self):

        pass

    def record(self,seconds,filename):
        self.chunk = 1024
        self.FORMAT = pyaudio.paInt16
        self.CHANNELS = 1
        self.RATE = 8000
        self.RECORD_SECONDS = seconds
        self.WAVE_OUTPUT_FILENAME = filename
        
        self.p = pyaudio.PyAudio()
        
        stream = self.p.open(format = self.FORMAT,
                        channels = self.CHANNELS,
                        rate = self.RATE,
                        input = True,
                        frames_per_buffer = self.chunk)

        #print "recording"
        
        all = []
        for i in range(0, self.RATE / self.chunk * self.RECORD_SECONDS):
            data = stream.read(self.chunk)
            all.append(data)
            
        #print "done recording"

        stream.close()
        self.p.terminate()

        # write data to WAVE file
        data = ''.join(all)
        wf = wave.open(self.WAVE_OUTPUT_FILENAME, 'wb')
        wf.setnchannels(self.CHANNELS)
        wf.setsampwidth(self.p.get_sample_size(self.FORMAT))
        wf.setframerate(self.RATE)
        wf.writeframes(data)
        wf.close()

if __name__ == '__main__':

    print "Wanker"
    




