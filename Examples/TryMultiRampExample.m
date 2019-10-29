%% BROKEN - Doesn't do anything useful really, excersize left to the user

% Desired Frequency
freqlist = [ 1e6, 10e6, 5e6, 6e6, 1.5e6];
phase = 45; 
timefreq = [ 1,     2,    1,  .5,   1  ];

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] = openconn('192.168.0.45', 0) ;
[knownCFR, stack] = resetCFR(stack,2);

if freqlist(1) < freqlist(2)
    stack = twosingletones(stack, 0, 1, 0, freqlist(1), 1, phase, freqlist(1));
    mirror = 1;
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(1), 1, 360-phase, freqlist(1));
    mirror = 0;
end
stack = rampdown(stack,2);
stack = stophold(stack,2);
[knownCFR, stack] = setDRGFreq(  stack, 2, knownCFR);
% [knownCFR, stack] = setAutoClearDRGAccum(stack, 2, 1, knownCFR);
[knownCFR, stack] = setClearPhaseAccum(stack, 2, 1, knownCFR);
[knownCFR, stack] = setClearDRGAccum(stack, 2, 1, knownCFR);
stack = flexupdateboth(stack);

[knownCFR, stack]= setClearPhaseAccum(stack, 2, 0, knownCFR);
[knownCFR, stack] = setClearDRGAccum(stack, 2, 0, knownCFR);
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);


[knownCFR, stack] = setDRGEnable(stack, 2, 1, knownCFR);
[stack, ~, ~, ~] = rampfreqtime(stack, 2, freqlist(1), freqlist(2), timefreq(1)); 
stack = flexupdateboth(stack);
stack = waitforRackA(stack,2);
stack = rampup(stack,2);
stack = pulseB(stack,150);

for f=2:1:numel(freqlist)-1
    
if mirror
    stack = twosingletones(stack, 0, 1, 0, freqlist(f), 1, phase, freqlist(f));
    [stack, ~, ~, ~] = rampfreqtimeM(stack, 2, freqlist(f), freqlist(f+1), timefreq(f)); 
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(f), 1, 360-phase, freqlist(f));
    [stack, ~, ~, ~] = rampfreqtimeNOM(stack, 2, freqlist(f), freqlist(f+1), timefreq(f)); 
end

stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);

if freqlist(f) < freqlist(f+1)
    stack = rampup(stack,2);
else
    stack = rampdown(stack,2);
end

stack = pulseB(stack,150);


end


stack = flexflush(t, stack);




