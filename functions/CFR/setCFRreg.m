function [stack] = setCFRreg(stack, chan, cfrnum, theCFR)

switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:CFR',num2str(cfrnum),'=0x',theCFR]);
    case 1
        stack = flexstack(stack,['dcp 1 spi:CFR',num2str(cfrnum),'=0x',theCFR]);
    case 2
        stack = flexstack(stack,['dcp spi:CFR',num2str(cfrnum),'=0x',theCFR]);
end

end
