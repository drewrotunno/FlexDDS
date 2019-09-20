function [newknownCFR, stack] = masterCFR(stack, chan)
%% Set bits in this file to initialize all CFR's as you wish
%  write entire CFR register with presettings

%for reference
% defaultCFR = ['00410002';'004008C0'];  %default value
% CFR1: all 0's except: 22, 16, 1
% CFR2: all 0's except: 22, 11, 7, 6


% 1's and 0's only please! 
%% CFR 1
% 31:24
RAMenable = 0;              % 31
RamplayBackDestA = 0;       %   30
RamplayBackDestB = 0;       % 29
% open........              %   29....24
% 23:16
ManualOSKExtCon = 0;        % 23
InverseSincFilter = 1;      %   22
% open                      % 21
IntProfControlA = 0;        %   20
IntProfControlB = 0;        % 19
IntProfControlC = 0;        %   18
IntProfControlD = 0;        % 17
SelectDDSSine = 1;          %   16
% 15:8
LoadLRRatUpdate = 0;        % 15
AutoClearDRGAccum = 0;      %   14
AutoClearPhaseAccum = 0;    % 13
ClearDRGAccum = 0;          %   12
ClearPhaseAccum = 0;        % 11
LoadARRatUpdate = 0;        %   10
OSKEnable = 0;              % 9
SelectAutoOSK = 0;          %   8
% 7:0
DigitalPowerDown = 0;       % 7
DACPowerDown = 0;           %   6
REFCLKInputPowerDown = 0;   % 5
AuxDACPowerDownCont = 0;    %   4
ExtPowerDownCont = 0;       % 3
%open                       %   2
SDIOInputOnly = 1;          % 1
LSBFirst = 0;               %   0

binCFR{1} = [RAMenable, RamplayBackDestA, RamplayBackDestB,0,0,0,0,0,...
 ManualOSKExtCon,InverseSincFilter,0,IntProfControlA,IntProfControlB,IntProfControlC,IntProfControlD, SelectDDSSine,...
 LoadLRRatUpdate,AutoClearDRGAccum,AutoClearPhaseAccum,ClearDRGAccum,ClearPhaseAccum,LoadARRatUpdate,OSKEnable,SelectAutoOSK, ...
 DigitalPowerDown,DACPowerDown,REFCLKInputPowerDown,AuxDACPowerDownCont,ExtPowerDownCont,0,SDIOInputOnly,LSBFirst ];

hexCFR{1} = binaryVectorToHex(binCFR{1});

%% CFR 2
% 31:24
%open...                    % 31 ...... 25
EnableAmpSTP = 0;           %   24
% 23:16
InternalIOUpdate = 0;       % 23
SYNC_CLKEnable = 1;         %   22
RampDestA = 0;              % 21
RampDestB = 0;              %   20
DRGEnable = 0;              % 19
DRGNoDwellHigh = 0;         %   18
DRGNoDwellLow = 0;          % 17
ReadEffFTW = 0;             %   16
% 15:8
IOUpdateRateConA = 0;       % 15
IOUpdateRateConB = 0;       %   14
% open ..                   % 13 - 12
PDCLKEnable = 1;            % 11
PDCLKInv = 0;               %   10
TxEnableInv = 0;            % 9
% open = 0;                 %   8
% 7:0
MatLatEnable = 1;           % 7
DataAssHoldLast = 1;        %   6
SyncTimingValDis = 0;       % 5
ParallelDataEnable = 0;     %   4
FMGainA = 0;                % 3
FMGainB = 0;                %   2
FMGainC = 0;                % 1
FMGainD = 0;                %   0


binCFR{2} = [0,0,0,0,0,0,0,EnableAmpSTP,...
 InternalIOUpdate,SYNC_CLKEnable,RampDestA,RampDestB,DRGEnable,DRGNoDwellHigh,DRGNoDwellLow,ReadEffFTW,...
 IOUpdateRateConA,IOUpdateRateConB,0,0,PDCLKEnable,PDCLKInv,TxEnableInv,0,...
 MatLatEnable,DataAssHoldLast,SyncTimingValDis,ParallelDataEnable,FMGainA,FMGainB,FMGainC,FMGainD];

hexCFR{2} = binaryVectorToHex(binCFR{2});


switch chan
    case 0
        newknownCFR{1} = defaultCFR{1};  %default value
        newknownCFR{2} = lastCFR{2};
        stack = flexstack(stack,['dcp 0 spi:CFR1=0x', defaultCFR{1}(1,:)]);
        stack = flexstack(stack,['dcp 0 spi:CFR2=0x', defaultCFR{1}(2,:)]);
        stack = flexupdateone(stack,0);
    case 1
        newknownCFR{1} = lastCFR{1};
        newknownCFR{2} = defaultCFR{2};  %default value
        stack = flexstack(stack,['dcp 1 spi:CFR1=0x',defaultCFR{2}(1,:)]);
        stack = flexstack(stack,['dcp 1 spi:CFR2=0x',defaultCFR{2}(2,:)]);
        stack = flexupdateone(stack,1);
    case 2
        newknownCFR{1} = defaultCFR{1};  %default value
        newknownCFR{2} = defaultCFR{2};  %default value
        stack = flexstack(stack,['dcp spi:CFR1=0x',defaultCFR{1}(1,:)]);
        stack = flexstack(stack,['dcp spi:CFR2=0x',defaultCFR{1}(2,:)]);
        stack = flexupdateboth(stack);
end

end

