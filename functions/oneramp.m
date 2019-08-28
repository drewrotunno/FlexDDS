function [DRL, DSS, DRR, updown] = oneramp(freqstart, freqend, time)
%ONERAMP will calculate good freq and time steps for one DDS ramp.

% sweep direction
if(freqstart>freqend)
    updown = 1;
    highftw = freq2ftw(freqstart);
    lowftw = freq2ftw(freqend);
elseif(freqstart<freqend)
    updown = 0;
    lowftw = freq2ftw(freqstart);
    highftw = freq2ftw(freqend);
else
    disp('thats not a sweep');
    return
end

DRL = [lowftw, highftw];
DSS = [freq2ftw(6),freq2ftw(3)];
DRR = [uint2hex(uint16(150)) , uint2hex(uint16(150))];







end

