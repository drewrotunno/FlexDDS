% I hope this is a good guide for  sample session. 


% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
% t is the TCPIP element. 
% stack is a running list. We keep adding lines to the -stack-
% then we -flush- the whole stack at once. 

% grab the default CFR values on both channels, reset them to default. 
[knownCFR, stack] = resetCFR(stack,2);

% Edit the CFR, and maintain record of changes. 
% Here we enable amplitude control
% changes don't take place untio after an IO update trigger
[knownCFR, stack] = setEnableAmp(stack, 2, 1, knownCFR);
% Args: Stack - add to it
%       2 - both channels. 0/1 for single channel
%       1 - set bit to 'true'. 0 to un-set the bit
%       knownCFR - last value, so it spits out the new value. 

% set two outputs on        profile 0
stack = twosingletonesNOUP(stack, 0,    .75, 90, 20e6,     1.0, 270, 20e6);
%                   amp/phase/freq ...  -chan 0------      -chan 1------

% When RackA is triggered, these updates will take place. 
stack = updateOnRackA(stack,2);
% This is required for synchronous timing. Updating often allows 4/8/40 ns
% delays between starts of instructions.

% Send all instructions to the FIFO
stack = flexflush(t, stack);

% Trigger RackA or press the Green Button.







