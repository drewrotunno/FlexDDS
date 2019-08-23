function setASF(t, chan, amp)
%SETPOW Write to register 0x09, Amplitute Scale Factor
%   Detailed explanation goes here


switch chan
    case 0
        flexsnd(t,['dcp 0 spi:ASF=0x',amp2ASF(amp)]);
    case 1
        flexsnd(t,['dcp 1 spi:ASF=0x',amp2ASF(amp)]);
    case 2
        flexsnd(t,['dcp spi:ASF=0x',amp2ASF(amp)]);
end

% flexlst(t);
end

