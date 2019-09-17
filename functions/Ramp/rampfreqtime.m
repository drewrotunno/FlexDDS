% function [DRL, DRSS, DRR] = rampfreqtime(freqstart, freqend, timesec)
%ONERAMP will calculate good freq and time steps for one DDS ramp.

freqstart = 10e6;
freqend  = 20e6;
timesec = 20;

%               to int            ns   /clock 250 MHz
tsteptot  = uint64(round(timesec.*1e9./4));
error = 1e-3;   % or whatever
maxword = 100;      % 400 ns or 23 Hz

if(freqstart>freqend)
%     updown = 1;
    highftw = freq2ftw(freqstart);
    lowftw = freq2ftw(freqend);
    fsteptot = hex2uint32(highftw)-hex2uint32(lowftw);
elseif(freqstart<freqend)
%     updown = 0;
    lowftw = freq2ftw(freqstart);
    highftw = freq2ftw(freqend);
    fsteptot = hex2uint32(highftw)-hex2uint32(lowftw);
else
    disp('thats not a sweep');
    return
end

if fsteptot > tsteptot      % slope > 1, 
    num = double(fsteptot);
    den = double(tsteptot);
elseif fsteptot < tsteptot
    num = double(tsteptot);
    den = double(fsteptot);
else    % they're equal, 1:1
    timestep = 1;
    freqstep = 1;
end

slope = num/den;

% how far from one is the slopr? 
diffq = abs( (slope - round(slope)) / slope) ;

while diffq > error
    diff = abs(slope-round(slope));
    
    
    
end

DRL  = [highftw, lowftw];
DRSS = [freq2ftw(0),freq2ftw(0)];
DRR  = [uint2hex(uint16(tsteptot)) , uint2hex(uint16(tsteptot))];


% end

