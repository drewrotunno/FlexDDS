function newknownCFR = resetCFR(t, chan, lastCFR)
% t, chan
%  reseto to default value

defaultCFR{1} = ['00410002';'004008C0'];  %default value
defaultCFR{2} = ['00410002';'004008C0'];  %default value

switch chan
    case 0
        newknownCFR{1} = defaultCFR{1};  %default value
        newknownCFR{2} = lastCFR{2};
        flexsnd(t,['dcp 0 spi:CFR1=0x', defaultCFR{1}(1,:)]);
        flexsnd(t,['dcp 0 spi:CFR2=0x', defaultCFR{1}(2,:)]);
        flexupdateone(t,0);
    case 1
        newknownCFR{1} = lastCFR{1};
        newknownCFR{2} = defaultCFR{2};  %default value
        flexsnd(t,['dcp 1 spi:CFR1=0x',defaultCFR{2}(1,:)]);
        flexsnd(t,['dcp 1 spi:CFR2=0x',defaultCFR{2}(2,:)]);
        flexupdateone(t,1);
    case 2
        newknownCFR{1} = defaultCFR{1};  %default value
        newknownCFR{2} = defaultCFR{2};  %default value
        flexsnd(t,['dcp spi:CFR1=0x',defaultCFR{1}(1,:)]);
        flexsnd(t,['dcp spi:CFR2=0x',defaultCFR{1}(2,:)]);
%         flexsnd(t,'dcp update:u');
        flexupdateboth(t);
end

end

