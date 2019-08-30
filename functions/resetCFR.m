function newknownCFR = resetCFR(t, chan)
% t, chan
%  reseto to default value
%
newknownCFR = ['00410002';'004008C0'];  %default value


switch chan
    case 0
        flexsnd(t,['dcp 0 spi:CFR1=0x00410002']);
        flexsnd(t,['dcp 0 spi:CFR2=0x004008C0']);
        flexupdateone(t,0);
    case 1
        flexsnd(t,['dcp 1 spi:CFR1=0x00410002']);
        flexsnd(t,['dcp 1 spi:CFR2=0x004008C0']);
        flexupdateone(t,1);
    case 2
        flexsnd(t,['dcp spi:CFR1=0x00410002']);
        flexsnd(t,['dcp spi:CFR2=0x004008C0']);
        flexupdateboth(t);
end

end

