function [DRL, DRSS, DRR] = rampfreqtime(t,chan, freqstart, freqend, timesec)
%ONERAMP will calculate good freq and time steps for one DDS ramp.

tstepns = timesec.*1e9;
error = 1e-3;
maxword = 100;      % 400 ns or 23 Hz


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

DRL  = [highftw, lowftw];
DRSS = [freq2ftw(0),freq2ftw(0)];
DRR  = [uint2hex(uint16(numsteps)) , uint2hex(uint16(numsteps))];
% 
% switch chan
%     case 0
%         flexsnd(t,['dcp 0 spi:DRL=0x',DRL]);
%         flexsnd(t,['dcp 0 spi:DRSS=0x',DRSS]);
%         flexsnd(t,['dcp 0 spi:DRR=0x',DRR]);
%         flexupdateone(t,0)
%     case 1
%         flexsnd(t,['dcp 1 spi:DRL=0x',DRL]);
%         flexsnd(t,['dcp 1 spi:DRSS=0x',DRSS]);
%         flexsnd(t,['dcp 1 spi:DRR=0x',DRR]);
%         flexupdateone(t,1)
%     case 2
%         flexsnd(t,['dcp spi:DRL=0x',DRL]);
%         flexsnd(t,['dcp spi:DRSS=0x',DRSS]);
%         flexsnd(t,['dcp spi:DRR=0x',DRR]);
%         flexupdateboth(t)
% end

end

