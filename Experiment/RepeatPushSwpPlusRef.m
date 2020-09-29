% Push: sweep in, hold, sweep back
clear all;
% Ramp 2 Chans with the same frequencies, but a 
% constant phase difference between channels

endFreq         =  8.389e6;     % in Hz, one you want, will add ref late
startFreq       =  4.4e6;
refFreq         =100.000e6;
phasediff       = 210;         % degrees
repeat         = 75;

sweepTime = .1e-3;     % seconds
holdTime  =1.0e-3;     % seconds

% Establish a connection to the FlexDDS via IP + slot#
[t1, stack1] =openconn('192.168.0.45', 0);
[knownCFR1, stack1] = resetCFR(stack1,2);

% Set DRG to Ramp Mode
[knownCFR1, stack1] = setDRGFreq(  stack1, 2, knownCFR1);
[knownCFR1, stack1] = setDRGEnable(stack1, 2,  1, knownCFR1);
% ensure Ramp direction is down
stack1 = rampdown(stack1, 2);

% Establish a phase diffrence between channels
%stack =onesingletone(stack, chan, prof, amp1,     phase,    freqHz)
if startFreq < endFreq
    stack1 = onesingletone( stack1,    0,    0,    1,phasediff, startFreq+refFreq);
    stack1 = onesingletone( stack1,    1,    0,    1,        0, startFreq+refFreq);
else    % need to use mirror freqs, mirror phase too
    stack1 = onesingletoneM(stack1,    0,    0,    1,360-phasediff, startFreq+refFreq);
    stack1 = onesingletoneM(stack1,    1,    0,    1,            0, startFreq+refFreq);
end
stack1 = flexupdateboth(stack1);

% Phase lock on Rack A
[knownCFR1, stack1] = setClearPhaseAccum(stack1, 2, 1, knownCFR1);
stack1 = flexupdateboth(stack1);
[knownCFR1, stack1]= setClearPhaseAccum(stack1, 2, 0, knownCFR1);
stack1 = waitforRackA(stack1,2);
stack1 = flexupdateboth(stack1);        % start freqs on 1st trigger
                                    % needed for phase-matching

% Convert to Words, and Send the Ramp parameters
[stack1, FW, TW, timediff] = rampfreqtime(stack1, 2, startFreq+refFreq, endFreq+refFreq, sweepTime);

% If you already know what words to use: 
% [stack] = onerampfreq(stack,chan, freqstart, freqend, tstepns, freqstephz)
stack1 = flexupdateboth(stack1);

for r = 1:1:repeat
    % sweep up on first trigger
    stack1 = waitforRackA(stack1, 2);
    stack1 = rampup(stack1, 2);         % ramp start on second trigger
    % wait for ramp over
    stack1 = waitForEvent(stack1, 2, 35);
    %use FlexDDS to set 500 us pulse hold time - input in microseconds
    stack1 = waitus(stack1, 2, holdTime*1e6);
    stack1 = rampdown(stack1, 2);
end
    
stack1 = flexflush(t1, stack1);



%%  set other channel to be const. reference
[t2, stack2] =openconn('192.168.0.45', 1);
[knownCFR2, stack2] = resetCFR(stack2,2);
%               amp/phase/freq ...  -chan 0------      -chan 1------
stack2 = twosingletonesNOUP(stack2, 0, 1.0, 0, refFreq,     1.0, 0, refFreq);
stack2 = waitforRackA(stack2,2);
stack2 = flexupdateboth(stack2);

stack2 = flexflush(t2, stack2);
fclose('all');
disp(datestr(now,'HH:MM:SS'))