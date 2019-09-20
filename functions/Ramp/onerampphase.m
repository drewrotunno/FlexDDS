function [stack] = onerampphase(stack,chan, degstart, degend, tstepns, phasestepdeg)
%ONERAMP will calculate good freq and time steps for one DDS ramp.

% sweep direction
if(degstart>degend)
%     updown = 1;
    highpow = phase2powdeg32(degstart);
    lowpow = phase2powdeg32(degend);
elseif(degstart<degend)
%     updown = 0;
    lowpow = phase2powdeg32(degstart);
    highpow = phase2powdeg32(degend);
else
    disp('thats not a sweep');
    return
end

numsteps = floor(tstepns/4);

DRL = [highpow, lowpow];
DRSS = [phase2powdeg32(phasestepdeg),phase2powdeg32(phasestepdeg)];
DRR = [uint2hex(uint16(numsteps)) , uint2hex(uint16(numsteps))];

switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:DRL=0x',DRL]);
        stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS]);
        stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR]);
        stack = flexupdateone(stack,0);
    case 1
        stack = flexstack(stack,['dcp 1 spi:DRL=0x',DRL]);
        stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS]);
        stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR]);
        stack = flexupdateone(stack,1);
    case 2
        stack = flexstack(stack,['dcp spi:DRL=0x',DRL]);
        stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS]);
        stack = flexstack(stack,['dcp spi:DRR=0x',DRR]);
        stack = flexupdateboth(stack);
end

end

