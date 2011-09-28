#!/bin/bash 
# gathered from symbreg script 

# the make command does not generate static linked binaries it creates 
# a script to do it in runtime instead but why not providing a static tag to do that on make ?

cd $1
make clean
make 

g++ -pthread -o symbreg_bin SymbRegEvalOp.o SymbRegMain.o  -L/usr/lib ../../../../beagle/Coev/src/.libs/libbeagle-Coev.so ../../../../beagle/GP/src/.libs/libbeagle-GP.so ../../../../beagle/GA/src/.libs/libbeagle-GA.so ../../../../beagle/src/.libs/libbeagle.so ../../../../PACC/Threading/.libs/libpacc-threading.so ../../../../PACC/Math/.libs/libpacc-math.so ../../../../PACC/XML/.libs/libpacc-xml.so ../../../../PACC/Util/.libs/libpacc-util.so -lz -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/beagle/Coev/src/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/beagle/GP/src/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/beagle/GA/src/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/beagle/src/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/PACC/Threading/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/PACC/Math/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/PACC/XML/.libs -Wl,--rpath -Wl,/home/users/inf/rafael/beagle-3.0.3_bowmore/PACC/Util/.libs
