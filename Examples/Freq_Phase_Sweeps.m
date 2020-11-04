% Push: sweep in, hold, sweep back
clear all;
% Ramp 2 Chans with the same frequencies, but a 
% constant phase difference between channels
% one trigger sets up phase, two more sweep up and back

endFreq         =  19.5e6;       % in Hz, one you want
midFreq         =  19.4e6;       % intermediate frequency (+2 trap)
startFreq       =  11e6;       % where you sweep from. > w_0/2 preferred
refFreq         =100.000e6;     % mixer reference freq, in Hz
freqswpTime1       = 500e-3;     % seconds
freqswpTime2       = 500e-3;     % seconds

phaseinit       =  90;         % degrees chan A will be ahead of B
phasefinal       =  180;         % degrees chan A will be ahead of B
phaseswpTime1       = 500e-3;     % seconds
phaseswpTime2       = 500e-3;     % seconds


%% set A/B to be phase shifted
% Establish a connection to the FlexDDS via IP + slot#
[t1, stack1] =openconn('192.168.0.45', 0);
[knownCFR1, stack1] = resetCFR(stack1,2);

[knownCFR1, stack1] = setDRGPhase(  stack1, 0, knownCFR1);
[knownCFR1, stack1] = setDRGEnable(stack1, 0,  1, knownCFR1);

%stack =onesingletone(stack, chan, prof, amp1,     phase,    freqHz)
stack1 = onesingletone( stack1,    0,    0,    1,phasefinal, refFreq);
stack1 = onesingletone( stack1,    1,    0,    1,        0, refFreq);

% Phase lock on Rack A
[knownCFR1, stack1] = setClearPhaseAccum(stack1, 2, 1,knownCFR1);
stack1 = flexupdateboth(stack1);
[knownCFR1, stack1]= setClearPhaseAccum(stack1, 2, 0,knownCFR1);
stack1 = waitforRackA(stack1,2);
stack1 = flexupdateboth(stack1);        % start freqs on 1st trigger

phaselist = [phaseinit,phaseinit,phasefinal,phaseinit,phaseinit];
phasetimes = [freqswpTime1,phaseswpTime1,phaseswpTime2,freqswpTime2];

stack1 = multiphasetime(stack1, 2, phaselist, phasetimes);

stack1 = flexflush(t1, stack1);
%%  set other channel to be sweeping freq reference
[t2, stack2] =openconn('192.168.0.45', 1);
[knownCFR2, stack2] = resetCFR(stack2,2);

% Set DRG to Ramp Mode
[knownCFR2, stack2] = setDRGFreq(  stack2, 0, knownCFR2);
[knownCFR2, stack2] = setDRGEnable(stack2, 0,  1, knownCFR2);
% ensure Ramp direction is down
% stack2 = rampdown(stack2, 0);

% Establish a phase diffrence between channels
%stack =onesingletone(stack, chan, prof, amp1,     phase,    freqHz)
if startFreq < midFreq
    stack2 = onesingletone( stack2,    0,    0,    1,       0, startFreq+refFreq);
%     stack2 = onesingletone( stack2,    1,    0,    1,       0, startFreq+refFreq);
else    % need to use mirror freqs, mirror phase too
    stack2 = onesingletoneM(stack2,    0,    0,    1,       0, startFreq+refFreq);
%     stack2 = onesingletoneM(stack2,    1,    0,    1,       0,  startFreq+refFreq);
end
%               amp/phase/freq ...  -chan 0------      -chan 1------
% stack2 = twosingletonesNOUP(stack2, 0, 1.0, 0, startFreq+refFreq,     1.0, 0, startFreq+refFreq);
% stack2 = waitforRackA(stack2,2);
% eat one, when A/B phase lock
stack2 = waitforRackA(stack2, 0);
stack2 = flexupdateone(stack2,0);

% Convert to Words, and Send the Ramp parameters
% [stack2, FW, TW, timediff] = rampfreqtime(stack2, 0, startFreq+refFreq, endFreq+refFreq, sweepTime);
freqlist = [refFreq+startFreq,refFreq+midFreq,refFreq+midFreq,refFreq+midFreq,refFreq+endFreq];
freqtimes = [freqswpTime1,phaseswpTime1,phaseswpTime2,freqswpTime2];

stack2 = multifreqtime_TEST(stack2, 2, freqlist, freqtimes);

stack2 = flexflush(t2, stack2);
%% report
% phasediff
% midFreq
disp(datestr(now,'hh:MM:SS'))
fclose('all');
clear;