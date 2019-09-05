function newCFR = setRAMFreq(t, chan, lastCFR)

newCFR = setCFRbit(t, chan, 1, 30, 0, lastCFR);
newCFR = setCFRbit(t, chan, 1, 29, 0, newCFR);
        
end

