import sys
from os import popen 
from glob import glob
import re
from datetime import datetime,timedelta

indir=sys.argv[1]
files = glob(indir + 'results.*/results.*/*.log')
tm = re.compile(r"^(\d+):(\d+):(\d+)\s(\d+)\s(...)\s(\d+)")
dict_mes = { "Jan":1,"Feb":2,"Mar":3,"Apr":4,"May":5,"Jun":6,"Jul":7,"Aug":8,"Sep":9,"Oct":10,"Nov":11,"Dec":12} 

fit = []
totaldeltat = timedelta()
mindeltat = None
for flog  in files: 
    print flog
    getStartTimeCMD = "grep -m1 Current " + flog 
    cmd = popen( getStartTimeCMD ) 
    startDtTime = cmd.read()[32:-7]

    t=tm.search(startDtTime)
    hora=      int(t.group(1))
    minuto=    int(t.group(2))
    segundo=   int(t.group(3))
    dia=       int(t.group(4))
    mes=       dict_mes[ t.group(5) ] 

    dtstart = datetime(year=2011, month=mes, day=dia, hour=hora, minute=minuto) 

    getEndTimeCMD = "grep -m2 Current " + flog  + " | tail -n1 "
    cmd = popen( getEndTimeCMD ) 
    endDtTime = cmd.read()[32:-7]
    
    t=tm.search(endDtTime)
    hora=      int(t.group(1))
    minuto=    int(t.group(2))
    segundo=   int(t.group(3))
    dia=       int(t.group(4))
    mes=       dict_mes[ t.group(5) ] 

    dtend = datetime(year=2011, month=mes, day=dia, hour=hora, minute=minuto) 

    print startDtTime
    print endDtTime

    deltat = (dtend - dtstart)
    if not mindeltat: 
        mindeltat = deltat  
    elif deltat < mindeltat:
        mindeltat = deltat 

    totaldeltat =  totaldeltat + deltat
    # print (dtend - dtstart) 
   
print totaldeltat
print mindeltat







 
