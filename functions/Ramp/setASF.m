function stack = setASF(stack, chan, amp)
%SETPOW Write to register 0x09, Amplitute Scale Factor
%   Detailed explanation goes here


switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:ASF=0x',amp2ASF(amp)]);
    case 1
        stack = flexstack(stack,['dcp 1 spi:ASF=0x',amp2ASF(amp)]);
    case 2
        stack = flexstack(stack,['dcp spi:ASF=0x',amp2ASF(amp)]);
end

end

