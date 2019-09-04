function allowampl(t, lastCFR)

% flexsnd(t,'dcp spi:CFR2=0x014008C0');
% flexupdateboth(t)

setCFRbit(t,2,2,24,1,lastCFR);

end

