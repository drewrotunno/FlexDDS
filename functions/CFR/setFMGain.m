function newCFR = setFMGain(t, chan, bit3, bit2, bit1, bit0, lastCFR)

newCFR = setCFRbit(t, chan, 2, 3, bit3, lastCFR);
newCFR = setCFRbit(t, chan, 2, 2, bit2, newCFR);
newCFR = setCFRbit(t, chan, 2, 1, bit1, newCFR);
newCFR = setCFRbit(t, chan, 2, 0, bit0, newCFR);
        
end

