% Phased push/pull: sweep in, hold, sweep back
clear all;
% Ramp 2 Chans with the same frequencies, but a 
% constant phase difference between channels
% one trigger sets up phase, two more sweep up and back

holdFreq        =  21e6;       % in Hz, one you want
startFreq       =  31e6;       % where you sweep from. >= w_0/2 preferred
endDropFreq     =  31e6;       % high blue detuned -> project into mfs 
refFreq         =100.000e6;     % mixer reference freq, in Hz

% +2
SNVswpstart   = (6834+60.9+1)*1e6;      %come from above
% SNVswpend     = (6834+60.9+2)*1e6;      % don't sweep, keep in 2
SNVswpend     = (6834+60.88-1)*1e6;      % all to +1
% SNVswpend     = (6834+60.95)*1e6;      % 50 / 50 in each (resonant) 1ms dc
% SNVswpend     = (6834+60.86)*1e6;      % 50 / 50 in each (resonant) 2ms dc
% SNVswpend     = (6834+60.90)*1e6;      % put more in +2
% SNVswpend     = (6834+60.85)*1e6;      % put more in +1

phase         = 290;

pop1swptime       = .100e-3;     % seconds
catchswp       = 1e-3;     % seconds
droptime       = 1e-3;     % seconds

resettime           = 1e-3;
% repeat =50;

freqlist  = refFreq+[startFreq, startFreq, holdFreq, endDropFreq];
synthlist  = [SNVswpstart, SNVswpend, SNVswpend, SNVswpend]./64;
% monitor = unique(synthlist*32)
phaselist = [phase,phase,phase,phase];
timelist  = [pop1swptime,catchswp,droptime];
% freqlist  = repmat(freqlist1,1,repeat);
% phaselist = repmat(phaselist1,1,repeat);
% timelist  = repmat(timelist1,1,repeat);
% timelist(end) = [];

%% set A/B to be phase shifted
% Establish a connection to the FlexDDS via IP + slot#
[t1, stack1] =openconn('192.168.0.45', 0);
[knownCFR1, stack1] = resetCFR(stack1,2);

[knownCFR1, stack1] = setDRGPhase(  stack1, 0, knownCFR1);
[knownCFR1, stack1] = setDRGEnable(stack1, 0,  1, knownCFR1);

% stack = twosingletones(stack, prof, amp1,  phase1, freqHz1, amp2, phase2, freqHz2)
% stack1 = twosingletones( stack1,   0,    1,        0, refFreq,    1,        0, refFreq);
% stack =onesingletone(stack, chan, prof, amp1,     phase,    freqHz)
stack1 = onesingletone( stack1,    0,    0,    1,       0, refFreq);
stack1 = onesingletone( stack1,    1,    0,    1,        0, refFreq);

% Phase lock on Rack A
[knownCFR1, stack1] = setClearPhaseAccum(stack1, 2, 1,knownCFR1);
stack1 = flexupdateboth(stack1);
[knownCFR1, stack1]= setClearPhaseAccum(stack1, 2, 0,knownCFR1);
stack1 = waitforRackA(stack1,2);
stack1 = flexupdateboth(stack1);        % start freqs on 1st trigger


stack1 = multiphasetime(stack1, 0, phaselist, timelist);

stack1 = flexflush(t1, stack1);
%%  set other channel to be sweeping freq reference
[t2, stack2] =openconn('192.168.0.45', 1);
[knownCFR2, stack2] = resetCFR(stack2,2);

% Set DRG to Ramp Mode
[knownCFR2, stack2] = setDRGFreq(  stack2, 2, knownCFR2);
[knownCFR2, stack2] = setDRGEnable(stack2, 2,  1, knownCFR2);

% Establish a phase diffrence between channels
%stack =onesingletone(stack, chan, prof, amp1,     phase,    freqHz)
if startFreq < holdFreq
    stack2 = onesingletone( stack2,    0,    0,    1,       0, startFreq+refFreq);
else   
    stack2 = onesingletoneM(stack2,    0,    0,    1,       0, startFreq+refFreq);
end
if SNVswpstart < SNVswpend
    stack2 = onesingletone( stack2,    1,    0,    1,       0, SNVswpstart);
else   
    stack2 = onesingletoneM(stack2,    1,    0,    1,       0,  SNVswpstart);
end
stack2 = flexupdateboth(stack2);
% eat one, when A/B phase lock
% stack2 = waitforRackA(stack2, 0);
% stack2 = waitforRackA(stack2, 1);
stack2 = waitforRackA(stack2,2);


stack2 = multifreqtime(stack2, 0, freqlist, timelist);
stack2 = multifreqtime(stack2, 1, synthlist, timelist);

stack2 = flexflush(t2, stack2);

%% report
fclose('all');
disp(datestr(now,'hh:MM:SS'))
clear;