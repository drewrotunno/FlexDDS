function [stack, freqstep, timestep, timediff] = rampfreqtimeNOM(stack, chan, freqstart, freqend, timesec)
%ONERAMP will calculate good freq and time steps for one DDS ramp.
% This method allows for total times close to desired lengths when the
% ratio of words is near one. 
% Summary: Determine the slope desired in FTW / Clock cycles
%  Find distance of this value to an integer diff = (slope - round(slope))
%  Multiply by this reciprocal (1/ diff) to get numbers closer to integers
%  Repeat until desired errors is achieved. 
%  rough Ex: 5/6 -- > diff = 1/6 --> mult = 6
%   Words are 5 and 6, instead of rounding to one and one

%        to int            ns   /clock @ 250 MHz
tsteptot = round((timesec.*1e9)./4);
error    = 1e-3;   % or whatever
maxword  = 100;      % 400 ns or 23 Hz

if freqstart > freqend
    lowftw = freq2ftw(freqend);     % use mirror freqs?? always start low and go up
    highftw  = freq2ftw(freqstart);
elseif freqstart < freqend
    lowftw  = freq2ftwM(freqend);
    highftw = freq2ftwM(freqstart);
else
    disp('thats not a sweep');
    return
end
fsteptot = hex2uint32(highftw)-hex2uint32(lowftw);

% make num the larger value, proper fraction: num/den
if fsteptot > tsteptot      % slope > 1, 
    num = double(fsteptot);
    den = double(tsteptot);
elseif fsteptot <= tsteptot  % slope < 1
    num = double(tsteptot);
    den = double(fsteptot);
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

if fsteptot > tsteptot
    freqword = uint32( round( other*num/den) );
    timeword = uint16( other );
    freqstep = round(other*num/den)*1e9/2^32;
    timestep = other*4e-9;
else 
    timeword = uint16( round( other*num/den ) );
    freqword = uint32( other );
    freqstep = other*1e9/2^32;
    timestep = round(other*num/den)*4e-9;
end
timediff = timestep * ( double(fsteptot) / double(freqword)) - timesec ;


DRL  = [highftw, lowftw];
DRSS = [uint2hex( freqword ) , uint2hex( freqword ) ];
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

