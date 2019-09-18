function [DRL, DRSS, DRR, freqstep, timestep] = rampfreqtime(freqstart, freqend, timesec)
%ONERAMP will calculate good freq and time steps for one DDS ramp.

%        to int            ns   /clock @ 250 MHz
tsteptot = round((timesec.*1e9)./4);
error    = 1e-3;   % or whatever
maxword  = 100;      % 400 ns or 23 Hz

if(freqstart>freqend)
    highftw = freq2ftw(freqstart);
    lowftw = freq2ftw(freqend);
elseif(freqstart<freqend)
    lowftw = freq2ftw(freqstart);
    highftw = freq2ftw(freqend);
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

if num > den
    freqword = uint32( round( slope ) );
    timeword = uint16( other );
    freqstep = round(slope)*1e9/2^32;
    timestep = other*4e-9;
else 
    timeword = uint16( round( slope ) );
    freqword = uint32( other );
    freqstep = round(slope)*1e9/2^32;
    timestep = other*4e-9;
end

DRL  = [highftw, lowftw];
DRSS = [uint2hex( freqword ) , uint2hex( freqword ) ];
DRR  = [uint2hex( timeword ) , uint2hex( timeword ) ];


end

