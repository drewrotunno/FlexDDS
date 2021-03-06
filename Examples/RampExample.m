% Make a Ramp using the End points and Total time of ramp
% Phases will not remain be continuous 
%   if you trigger during the sweep
% Set initial phase as STP profiles if desired. 
% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 2);
% t is the TCPIP element. 
% stack is a running list. We keep adding lines to the -stack-
% then we -flush- the whole stack at once. 

% grab the default CFR values on both channels, reset them to default. 
[knownCFR, stack] = resetCFR(stack,2);

% Set DRG to Ramp Mode
[knownCFR, stack] = setDRGFreq(  stack, 2, knownCFR);
[knownCFR, stack] = setDRGEnable(stack, 2,  1, knownCFR);
% ensure Ramp direction is down
stack = rampdown(stack, 2);

% Variables
startFreq   =  2e6;        % in Hz
endFreq     = 200e6;
time        =   10  ;        % in seconds

% Convert to Words, and Send the Ramp parameters
[stack, FW, TW, timediff] = rampfreqtime(stack, 2, startFreq, endFreq, time);

% If you already know what words to use: 
% [stack] = onerampfreq(stack,chan, freqstart, freqend, tstepns, freqstephz)

stack = flexupdateboth(stack);

% repeat_up_down = 1;

% for num = 1:1:repeat_up_down
    % now on triggers, change ramp direction
    stack = waitforRackA(stack, 2);
%     stack = waitForEvent(stack,2,35);     % wait for ramp over 
    stack = rampup(stack, 2);
    
%     stack = waitforRackA(stack, 2);
%     stack = waitForEvent(stack,2,35);     % wait for ramp over 
%     stack = rampdown(stack, 2);
% end
% stack'

% Are you guys silly? I'm still gonna send it 
% https://www.youtube.com/watch?v=WIrWyr3HgXI
stack = flexflush(t, stack);


