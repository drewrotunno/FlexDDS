% Set two outputs of a slot to be Cos and Sin components
% For IQ modulation, not with phase but with cos/sin DDS

% Desired Frequency
freq = 20e6;

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
[knownCFR, stack] = resetCFR(stack,2);

% Set one on Sin, one on Cos
[knownCFR, stack] = setDDScos(stack, 1, knownCFR);
[knownCFR, stack] = setDDSsin(stack, 0, knownCFR);

stack = twosingletones(stack, 0, 1, 0, freq, 1, 0, freq);

% Needed for phase sync
[knownCFR, stack] = setClearPhaseAccum(stack, 2, 1, knownCFR);
stack = flexupdateboth(stack);
[knownCFR, stack]= setClearPhaseAccum(stack, 2, 0, knownCFR);
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);

stack = flexflush(t, stack);

% Trigger RackA or press the Green Button.







