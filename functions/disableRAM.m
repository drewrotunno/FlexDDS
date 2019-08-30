function newCFR = disableRAM(t, chan, lastCFR)

        newCFR = setCFRbit(t,chan,1,31,0,lastCFR);
        
end

