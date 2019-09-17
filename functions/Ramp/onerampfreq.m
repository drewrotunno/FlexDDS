function [DRL, DRSS, DRR] = onerampfreq(t,chan, freqstart, freqend, tstepns, freqstephz)
%Use this one if you know exactly what time step and freq steps you'll
%need. Use rampfreqtime() if you know total freq/time and want it to
%calcuate what step words you should use. 

% sweep direction
if(freqstart>freqend)
%     updown = 1;
    highftw = freq2ftw(freqstart);
    lowftw = freq2ftw(freqend);
elseif(freqstart<freqend)
%     updown = 0;
    lowftw = freq2ftw(freqstart);
    highftw = freq2ftw(freqend);
else
    disp('thats not a sweep');
    return
end

numsteps = floor(tstepns/4);

DRL = [highftw, lowftw];
DRSS = [freq2ftw(freqstephz),freq2ftw(freqstephz)];
DRR = [uint2hex(uint16(numsteps)) , uint2hex(uint16(numsteps))];

switch chan
    case 0
        flexsnd(t,['dcp 0 spi:DRL=0x',DRL]);
        flexsnd(t,['dcp 0 spi:DRSS=0x',DRSS]);
        flexsnd(t,['dcp 0 spi:DRR=0x',DRR]);
        flexupdateone(t,0)
    case 1
        flexsnd(t,['dcp 1 spi:DRL=0x',DRL]);
        flexsnd(t,['dcp 1 spi:DRSS=0x',DRSS]);
        flexsnd(t,['dcp 1 spi:DRR=0x',DRR]);
        flexupdateone(t,1)
    case 2
        flexsnd(t,['dcp spi:DRL=0x',DRL]);
        flexsnd(t,['dcp spi:DRSS=0x',DRSS]);
        flexsnd(t,['dcp spi:DRR=0x',DRR]);
        flexupdateboth(t)
end

end

