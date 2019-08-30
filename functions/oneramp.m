function [DRL, DSS, DRR, updown] = oneramp(freqstart, freqend, tstepns, freqstephz)
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

numsteps = floor(tstepns/4);

DRL = [lowftw, highftw];
DSS = [freq2ftw(freqstephz),freq2ftw(freqstephz)];
DRR = [uint2hex(uint16(numsteps)) , uint2hex(uint16(numsteps))];







end

