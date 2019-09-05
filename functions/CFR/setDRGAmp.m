function newCFR = setDRGAmp(t, chan, lastCFR)

newCFR = setCFRbit(t,chan,2,21,1,lastCFR);
newCFR = setCFRbit(t,chan,2,20,0,newCFR);
        
end

