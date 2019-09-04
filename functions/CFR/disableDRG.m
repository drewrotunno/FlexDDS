function newCFR = disableDRG(t, chan, lastCFR)

        newCFR = setCFRbit(t,chan,2,19,0,lastCFR);
        
end

