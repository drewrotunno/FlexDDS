% I hope this is a good guide for sample session. 
clear all;

% Establish a connection to the FlexDDS via IP + slot#
[t1, stack1] =openconn('192.168.0.45', 0);

% grab the default CFR values on both channels, reset them to default. 
[knownCFR1, stack1] = resetCFR(stack1,2);
% set two outputs on        profile 0
%               amp/phase/freq ...  -chan 0------      -chan 1------
stack1 = twosingletonesNOUP(stack1, 0, 1.0, 90, 108.389e6,     1.0, 0, 108.389e6);
% stack1 = twosingletonesNOUP(stack1, 0, 1.0, 90,  58e6,     1.0, 0,  58e6);
% stack1 = twosingletonesNOUP(stack1, 0, 1.0, 90,   8e6,     1.0, 0,   8e6);
[knownCFR1, stack1] = setClearPhaseAccum(stack1, 2, 1, knownCFR1);
stack1 = flexupdateboth(stack1);
[knownCFR1, stack1]= setClearPhaseAccum(stack1, 2, 0, knownCFR1);
stack1 = waitforRackA(stack1,2);
stack1 = flexupdateboth(stack1);

stack1 = flexflush(t1, stack1);


[t2, stack2] =openconn('192.168.0.45', 1);
[knownCFR2, stack2] = resetCFR(stack2,2);
%               amp/phase/freq ...  -chan 0------      -chan 1------
stack2 = twosingletonesNOUP(stack2, 0, 1.0, 0, 100e6,     1.0, 0, 100e6);
% stack2 = twosingletonesNOUP(stack2, 0, 1.0, 0,  50e6,     1.0, 0,  50e6);
[knownCFR2, stack2] = setClearPhaseAccum(stack2, 2, 1, knownCFR2);
stack2 = flexupdateboth(stack2);
[knownCFR2, stack2]= setClearPhaseAccum(stack2, 2, 0, knownCFR2);
stack2 = waitforRackA(stack2,2);
stack2 = flexupdateboth(stack2);

stack2 = flexflush(t2, stack2);
fclose('all');