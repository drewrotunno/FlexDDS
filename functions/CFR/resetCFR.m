function [newknownCFR, stack] = resetCFR(stack, chan, lastCFR)
% t, chan
%  reseto to default value

defaultCFR{1} = ['00410002';'004008C0'];  %default value
defaultCFR{2} = ['00410002';'004008C0'];  %default value

switch chan
    case 0
        newknownCFR{1} = defaultCFR{1};  %default value
        newknownCFR{2} = lastCFR{2};
        stack = flexstack(stack,['dcp 0 spi:CFR1=0x', defaultCFR{1}(1,:)]);
        stack = flexstack(stack,['dcp 0 spi:CFR2=0x', defaultCFR{1}(2,:)]);
%         stack = flexupdateone(stack,0);
    case 1
        newknownCFR{1} = lastCFR{1};
        newknownCFR{2} = defaultCFR{2};  %default value
        stack = flexstack(stack,['dcp 1 spi:CFR1=0x',defaultCFR{2}(1,:)]);
        stack = flexstack(stack,['dcp 1 spi:CFR2=0x',defaultCFR{2}(2,:)]);
%         stack = flexupdateone(stack,1);
    case 2
        newknownCFR{1} = defaultCFR{1};  %default value
        newknownCFR{2} = defaultCFR{2};  %default value
        stack = flexstack(stack,['dcp spi:CFR1=0x',defaultCFR{1}(1,:)]);
        stack = flexstack(stack,['dcp spi:CFR2=0x',defaultCFR{1}(2,:)]);
%         stack = flexupdateboth(stack);
end

end

