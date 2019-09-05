function newCFR = setIOUpdateRate(t, chan, bit15, bit14 lastCFR)

newCFR = setCFRbit(t, chan, 2, 15, bit15, lastCFR);
newCFR = setCFRbit(t, chan, 2, 14, bit14, newCFR);
        
end

