function setPOW(t, chan, phaseDeg)
%SETPOW Write to register 0x08, Phase Offset Word
%   Detailed explanation goes here


switch chan
    case 0
        flexsnd(t,['dcp 0 spi:POW=0x',phase2powdeg(phaseDeg)]);
    case 1
        flexsnd(t,['dcp 1 spi:POW=0x',phase2powdeg(phaseDeg)]);
    case 2
        flexsnd(t,['dcp spi:POW=0x',phase2powdeg(phaseDeg)]);
end

% flexlst(t);
end

