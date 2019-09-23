function stack = setFTW(stack, chan, freq)
%SETPOW Write to register 0x07, Frequency Tuning Word
%   Detailed explanation goes here


switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:FTW=0x',freq2ftw(freq)]);
    case 1
        stack = flexstack(stack,['dcp 1 spi:FTW=0x',freq2ftw(freq)]);
    case 2
        stack = flexstack(stack,['dcp spi:FTW=0x',freq2ftw(freq)]);
end

end

