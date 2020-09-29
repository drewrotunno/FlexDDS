% I hope this is a good guide for sample session. 
clear all;

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
% t is the TCPIP element. 
% stack is a running list. We keep adding lines to the -stack-
% then we -flush- the whole stack at once. 

% grab the default CFR values on both channels, reset them to default. 
[knownCFR, stack] = resetCFR(stack,2);

% set two outputs on        profile 0
%               amp/phase/freq ...  -chan 0------      -chan 1------
stack = twosingletonesNOUP(stack, 0, 1.0, 0, 100e6,     1.0, 0, 108e6);
stack = flexupdateboth(stack);


% Send all instructions to the FIFO
stack = flexflush(t, stack);
fclose('all');