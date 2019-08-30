function newCFR = dumpDRG(t,lastCFR)

% sets bit 11='Clear Phase Accumulator'  in CFR1 to high 
% flexsnd(t,'dcp spi:CFR1=0x00410802')
% flexupdateboth(t)
intCFR = setCFRbit(t,2,1,12,1,lastCFR);

% sets bit 11='Clear Phase Accumulator'  in CFR1 to low (back to normal)
% flexsnd(t,'dcp spi:CFR1=0x00410002')
% flexupdateboth(t)
newCFR = setCFRbit(t,2,1,12,0,intCFR);

end

