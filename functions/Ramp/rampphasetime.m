function [stack, phasstep, timestep, timediff] = rampphasetime(stack, chan, phasestart, phaseend, timesec)
%ONERAMP will calculate good freq and time steps for one DDS ramp.

%        to int            ns   /clock @ 250 MHz
tsteptot = round((timesec.*1e9)./4);
error    = 1e-3;   % or whatever
maxword  = 100;      % 400 ns or 23 Hz

if(phasestart>phaseend)
    highpow = phase2powdeg32(phasestart);
    lowpow = phase2powdeg32(phaseend);
elseif(phasestart<phaseend)
    lowpow = phase2powdeg32(phasestart);
    highpow = phase2powdeg32(phaseend);
else
    disp('thats not a sweep');
    return
end
psteptot = hex2uint32(highpow)-hex2uint32(lowpow);

% make num the larger value, proper fraction: num/den
if psteptot > tsteptot      % slope > 1, 
    num = double(psteptot);
    den = double(tsteptot);
elseif psteptot <= tsteptot  % slope < 1
    num = double(tsteptot);
    den = double(psteptot);
end

slope = num/den;
other = 1;

% how far from one is the slope? 
diffq = abs( (slope - round(slope)) / slope) ;

while diffq > error
    diff = abs(slope-round(slope));
    q = round(1/diff);
    slope = slope*q;
    if(other*q > maxword)
        break
    else
        other = other*q;
    end
    diffq = abs( (slope - round(slope)) / slope) ;
end

if psteptot > tsteptot
    phasword = uint32( round( other*num/den) );
    timeword = uint16( other );
    phasstep = round(other*num/den)*360/2^32;
    timestep = other*4e-9;
else 
    timeword = uint16( round( other*num/den ) );
    phasword = uint32( other );
    phasstep = other*360/2^32;
    timestep = round(other*num/den)*4e-9;
end
timediff = timestep * ( double(psteptot) / double(phasword)) - timesec ;



DRL  = [highpow, lowpow];
DRSS = [uint2hex( phasword ) , uint2hex( phasword ) ];
DRR  = [uint2hex( timeword ) , uint2hex( timeword ) ];


switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:DRL=0x',DRL]);
        stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS]);
        stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR]);
%         stack = flexupdateone(stack,0);
    case 1
        stack = flexstack(stack,['dcp 1 spi:DRL=0x',DRL]);
        stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS]);
        stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR]);
%         stack = flexupdateone(stack,1);
    case 2
        stack = flexstack(stack,['dcp spi:DRL=0x',DRL]);
        stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS]);
        stack = flexstack(stack,['dcp spi:DRR=0x',DRR]);
%         stack = flexupdateboth(stack);
end


end

