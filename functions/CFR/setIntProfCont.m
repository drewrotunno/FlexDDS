function newCFR = setIntProfCont(t, chan, bit20, bit19, bit18, bit17, lastCFR)

newCFR = setCFRbit(t, chan, 1, 20, bit20, lastCFR);
newCFR = setCFRbit(t, chan, 1, 19, bit19, newCFR);
newCFR = setCFRbit(t, chan, 1, 18, bit18, newCFR);
newCFR = setCFRbit(t, chan, 1, 17, bit17, newCFR);

        
end

