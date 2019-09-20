function [newknownCFR, stack] = setCFRbit(stack, chan, cfrnum, bitnum, bitset, lastCFR)
%  setCFRbit(stack, chan, cfrnum, bitnum, bitset, lastCFR)
%  t = TCP connection
% chan = 0/1 for DDS 0/1, 2 for both
% cfrnum=  1 or 2, only ones we have access to
% bitnum= which register: 0:31, numbered by AD9910 manual
% bitset= 0 or 1, what to set it to
% lastCFR= last known. Will nuse default if this is 0
%       needed for multiple changes. Will return updated CFR
%
%% disp(nargin)
% sanitize. 
if cfrnum==1 || cfrnum==2; else disp('not a valid CFR number. Try 1 or 2 ');return; end
if chan==0||chan==1||chan==2; else disp('not a valid Channel number. Try 0/1 or 2 for both ');return; end

% if ischar(lastCFR{chan+1}(cfrnum,:))||isstr(lastCFR{chan+1}(cfrnum,:))
%     if strcmp(lastCFR{chan+1}(cfrnum,1:2),'0x');    lastCFR{chan+1}=lastCFR{chan+1}(cfrnum,3:end); end
%     if length(lastCFR{chan+1}(cfrnum,:)) ~=8 ; disp('CFR is the wrong length. Try 0 for default'); return; end
% elseif lastCFR==0
% else disp('CFR is the wrong length. Try 0 for default'); return; end 
if ~(bitset==0 || bitset==1); disp('Bitset should be 0 or 1');return; end

if size(lastCFR,2)== 1%lastCFR==0 && 
    lastCFR = cell(1,2);
    lastCFR{1} = ['00410002';'004008C0'];  %default value
    lastCFR{2} = ['00410002';'004008C0'];  %default value
end

switch chan
    case 0
        binCFR{1} = hex2bin(lastCFR{1}(cfrnum,:));
        binCFR{1}(32-bitnum) = bitset;
        newhexCFR{chan+1} = binaryVectorToHex(binCFR{1});
    case 1
        binCFR{2} = hex2bin(lastCFR{2}(cfrnum,:));
        binCFR{2}(32-bitnum) = bitset;
        newhexCFR{2} = binaryVectorToHex(binCFR{2});
    case 2
        binCFR{1} = hex2bin(lastCFR{1}(cfrnum,:));
        binCFR{1}(32-bitnum) = bitset;
        newhexCFR{1} = binaryVectorToHex(binCFR{1});
        binCFR{2} = hex2bin(lastCFR{2}(cfrnum,:));
        binCFR{2}(32-bitnum) = bitset;
        newhexCFR{2} = binaryVectorToHex(binCFR{2});
end

switch cfrnum
    case 1
        switch chan
            case 0
                newknownCFR{1} = [newhexCFR{1}; lastCFR{1}(2,:)];
                newknownCFR{2} = lastCFR{2};
            case 1
                newknownCFR{1} = lastCFR{1};
                newknownCFR{2} = [newhexCFR{2}; lastCFR{2}(2,:)];
            case 2
                newknownCFR{1} = [newhexCFR{1}; lastCFR{1}(2,:)];
                newknownCFR{2} = [newhexCFR{2}; lastCFR{2}(2,:)];
        end
    case 2
        switch chan
            case 0
                newknownCFR{1} = [lastCFR{1}(1,:); newhexCFR{1}];
                newknownCFR{2} = lastCFR{2};
            case 1
                newknownCFR{1} = lastCFR{1};
                newknownCFR{2} = [lastCFR{2}(1,:); newhexCFR{2}];
            case 2
                newknownCFR{1} = [lastCFR{1}(1,:); newhexCFR{1}];
                newknownCFR{2} = [lastCFR{2}(1,:); newhexCFR{2}];
        end
end

switch chan
    case 0
        stack = flexstack(stack,['dcp 0 spi:CFR',num2str(cfrnum),'=0x',newhexCFR{1}]);
        stack = flexupdateone(stack,0);
    case 1
        stack = flexstack(stack,['dcp 1 spi:CFR',num2str(cfrnum),'=0x',newhexCFR{2}]);
        stack = flexupdateone(stack,1);
    case 2
        stack = flexstack(stack,['dcp 0 spi:CFR',num2str(cfrnum),'=0x',newhexCFR{1}]);
        stack = flexstack(stack,['dcp 1 spi:CFR',num2str(cfrnum),'=0x',newhexCFR{2}]);
        stack = flexupdateboth(stack);
end

end

