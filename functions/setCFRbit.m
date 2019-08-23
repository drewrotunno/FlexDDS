function newhexCFR = setCFRbit(t, chan, cfrnum, bitnum, bitset, lastCFR)
%  setCFRbit(t, chan, cfrnum, bitnum, bitset, lastCFR)
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

if ischar(lastCFR)||isstr(lastCFR)
    if strcmp(lastCFR(1:2),'0x');    lastCFR=lastCFR(3:end); end
    if length(lastCFR) ~=8 ; disp('CFR is the wrong length. Try 0 for default'); return; end
elseif lastCFR==0
else disp('CFR is the wrong length. Try 0 for default'); return; end 
if ~(bitset==0 || bitset==1); disp('Bitset should be 0 or 1');return; end

if lastCFR==0
    switch cfrnum
        case 1
            lastCFR = '00410002';  %default value
        case 2
            lastCFR = '004008c0';  %default value
    end
end
 
binCFR = hex2bin(lastCFR);

binCFR(32-bitnum) = bitset;

newhexCFR = binaryVectorToHex(binCFR);

switch chan
    case 0
%         ['dcp 0 spi:CFR',num2str(cfrnum),'=0x',newhexCFR]
        flexsnd(t,['dcp 0 spi:CFR',num2str(cfrnum),'=0x',newhexCFR]);
        flexupdateone(t,0);
    case 1
%         ['dcp 1 spi:CFR',num2str(cfrnum),'=0x',newhexCFR]
        flexsnd(t,['dcp 1 spi:CFR',num2str(cfrnum),'=0x',newhexCFR]);
        flexupdateone(t,1);
    case 2
%         ['dcp spi:CFR',num2str(cfrnum),'=0x',newhexCFR]
        flexsnd(t,['dcp spi:CFR',num2str(cfrnum),'=0x',newhexCFR]);
        flexupdateboth(t);
end

end

