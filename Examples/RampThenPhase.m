%% BROKEN - Want to ramp F then P, but that's another ball game to do it phase-continuously. 

% Desired Frequency
startfreq = 1e6;
midfreq   = 2e6;
endfreq   = 3e6;
phasediff = 30; 
timefreq = 1;

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
[knownCFR, stack] = resetCFR(stack,2);

stack = twosingletones(stack, 0, 1, 0, startfreq, 1, phasediff, startfreq);
stack = rampdown(stack,2);
stack = stophold(stack,2);

% DRG settings
[knownCFR, stack] = setDRGFreq(  stack, 2, knownCFR);
[knownCFR, stack] = setDRGEnable(stack, 2, 1, knownCFR);
[knownCFR, stack] = setAutoClearDRGAccum(stack, 2, 1, knownCFR);
% Timing
[knownCFR, stack] = setClearPhaseAccum(stack, 2, 1, knownCFR);
[knownCFR, stack] = setClearDRGAccum(stack, 2, 1, knownCFR);
stack = flexupdateboth(stack);
[knownCFR, stack]= setClearPhaseAccum(stack, 2, 0, knownCFR);
[knownCFR, stack] = setClearDRGAccum(stack, 2, 0, knownCFR);
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);


[stack, ~, ~, ~] = rampfreqtime(stack, 2, startfreq, midfreq, timefreq); 
stack = flexupdateboth(stack);
stack = waitforRackA(stack,2);
stack = rampup(stack,2);


[stack, ~, ~, ~] = rampfreqtime(stack, 2, midfreq, endfreq, timefreq); 
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);

[stack, ~, ~, ~] = rampfreqtime(stack, 2, endfreq, midfreq, timefreq); 
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);


[stack, ~, ~, ~] = rampfreqtime(stack, 2, midfreq, startfreq, timefreq); 
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);




stack = flexflush(t, stack);




