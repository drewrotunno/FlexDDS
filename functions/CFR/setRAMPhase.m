function newCFR = setRAMPhase(t, chan, lastCFR)

newCFR = setCFRbit(t, chan, 1, 30, 0, lastCFR);
newCFR = setCFRbit(t, chan, 1, 29, 1, newCFR);
        
end

