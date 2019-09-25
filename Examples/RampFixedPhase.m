% Another Ramp Example
clear all;
% Ramp 2 Chans with the same frequencies, but a 
% constant phase difference between channels

% Variables
startFreq       = 120e6;        % in Hz
endFreq         =  20e6;
phasediff       = 60;         % degrees
time            = 2.5;        % in seconds
repeat_up_down  = 3;

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
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

% Establish a phase diffrence between channels
%stack =onesingletone(stack, chan, prof, amp1,     phase,    freqHz)
if startFreq < endFreq
    stack = onesingletone( stack,    0,    0,    1,         0, startFreq);
    stack = onesingletone( stack,    1,    0,    1,phasediff, startFreq);
else    % need to use mirror freqs, mirror phase too
    stack = onesingletoneM(stack,    0,    0,    1,         0, startFreq);
    stack = onesingletoneM(stack,    1,    0,    1, 360-phasediff, startFreq);
end
stack = flexupdateboth(stack);

% Phase lock on Rack A
[knownCFR, stack] = setClearPhaseAccum(stack, 2, 1, knownCFR);
stack = flexupdateboth(stack);
[knownCFR, stack]= setClearPhaseAccum(stack, 2, 0, knownCFR);
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);

% Convert to Words, and Send the Ramp parameters
[stack, FW, TW, timediff] = rampfreqtime(stack, 2, startFreq, endFreq, time);

% If you already know what words to use: 
% [stack] = onerampfreq(stack,chan, freqstart, freqend, tstepns, freqstephz)

stack = flexupdateboth(stack);

stack = flexflush(t, stack);

% careful with this, Everything will hang on a wait


for num = 1:1:repeat_up_down
    % now on triggers, change ramp direction
    stack = waitforRackA(stack, 2);
    stack = rampup(stack, 2);
    
    stack = waitforRackA(stack, 2);
    stack = rampdown(stack, 2);
end

stack = flexflush(t, stack);

