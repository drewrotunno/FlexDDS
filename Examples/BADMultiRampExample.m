%%% BROKEN - phase discontinuities between sweeps. Check on the pulseB
%%% triggers. 

% Desired Frequency
freqlist = [ 1e6, 10e6, 5e6, 6e6, 1.5e6];
phase = 45; 
timefreq = 1;

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
[knownCFR, stack] = resetCFR(stack,2);

if freqlist(1) < freqlist(2)
    stack = twosingletones(stack, 0, 1, 0, freqlist(1), 1, phase, freqlist(1));
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(1), 1, 360-phase, freqlist(1));
end

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



if freqlist(1) < freqlist(2)
    stack = twosingletones(stack, 0, 1, 0, freqlist(1), 1, phase, freqlist(1));
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(1), 1, 360-phase, freqlist(1));
end

[stack, ~, ~, ~] = rampfreqtime(stack, 2, freqlist(1), freqlist(2), timefreq); 
stack = flexupdateboth(stack);
stack = waitforRackA(stack,2);
stack = rampup(stack,2);
stack = pulseB(stack,150);

if freqlist(2) < freqlist(3)
    stack = twosingletones(stack, 0, 1, 0, freqlist(2), 1, phase, freqlist(2));
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(2), 1, 360-phase, freqlist(2));
end
[stack, ~, ~, ~] = rampfreqtime(stack, 2, freqlist(2), freqlist(3), timefreq); 
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);
stack = pulseB(stack,150);

if freqlist(3) < freqlist(4)
    stack = twosingletones(stack, 0, 1, 0, freqlist(3), 1, phase, freqlist(3));
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(3), 1, 360-phase, freqlist(3));
end

[stack, ~, ~, ~] = rampfreqtime(stack, 2, freqlist(3), freqlist(4), timefreq); 
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);
stack = pulseB(stack,150);


if freqlist(4) < freqlist(5)
    stack = twosingletones(stack, 0, 1, 0, freqlist(4), 1, phase, freqlist(4));
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(4), 1, 360-phase, freqlist(4));
end

[stack, ~, ~, ~] = rampfreqtime(stack, 2, freqlist(4), freqlist(5), timefreq); 
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);
stack = pulseB(stack,150);


stack = flexflush(t, stack);




