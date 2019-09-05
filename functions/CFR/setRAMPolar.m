function newCFR = setRAMPolar(t, chan, lastCFR)

newCFR = setCFRbit(t, chan, 1, 30, 1, lastCFR);
newCFR = setCFRbit(t, chan, 1, 29, 1, newCFR);
        
end

