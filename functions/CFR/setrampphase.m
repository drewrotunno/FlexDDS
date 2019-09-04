function newCFR = setrampphase(t, chan, lastCFR)

        newCFR = setCFRbit(t,chan,2,21,0,lastCFR);
        newCFR = setCFRbit(t,chan,2,20,1,newCFR);
        
end

