function setFTW(t, chan, freq)
%SETPOW Write to register 0x07, Frequency Tuning Word
%   Detailed explanation goes here


switch chan
    case 0
        flexsnd(t,['dcp 0 spi:FTW=0x',freq2ftw(freq)]);
    case 1
        flexsnd(t,['dcp 1 spi:FTW=0x',freq2ftw(freq)]);
    case 2
        flexsnd(t,['dcp spi:FTW=0x',freq2ftw(freq)]);
end

% flexlst(t);
end

