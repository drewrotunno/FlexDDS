function newCFR = disableManOSKExt(t, chan, lastCFR)

        newCFR = setCFRbit(t,chan,1,23,0,lastCFR);
        
end

