function stack = setPOW(stack, chan, phaseDeg)
%SETPOW Write to register 0x08, Phase Offset Word
%   Detailed explanation goes here


switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:POW=0x',phase2powdeg(phaseDeg)]);
    case 1
        stack = flexstack(stack,['dcp 1 spi:POW=0x',phase2powdeg(phaseDeg)]);
    case 2
        stack = flexstack(stack,['dcp spi:POW=0x',phase2powdeg(phaseDeg)]);
end

end

