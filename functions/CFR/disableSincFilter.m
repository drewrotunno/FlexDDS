function newCFR = disableSincFilter(t, chan, lastCFR)

        newCFR = setCFRbit(t,chan,1,22,0,lastCFR);
        
end

