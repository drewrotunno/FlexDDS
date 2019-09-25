% I hope this is a good guide for sample session. 


% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
% t is the TCPIP element. 
% stack is a running list. We keep adding lines to the -stack-
% then we -flush- the whole stack at once. 

% grab the default CFR values on both channels, reset them to default. 
[knownCFR, stack] = resetCFR(stack,2);

% set two outputs on        profile 0
%               amp/phase/freq ...  -chan 0------      -chan 1------
stack = twosingletonesNOUP(stack, 0, 1.0, 0, 20e6,     1.0, 0, 20e6 + .25);
stack = flexupdateboth(stack);

% set two outputs on        profile 1
stack = twosingletonesNOUP(stack, 1, 1.0, 0, 69e6,     1.0, 180, 69e6);
% stack = updateOnRackA(stack,2); % when phase is important, use trigger
stack = flexupdateboth(stack);

% set two outputs on        profile 7
% stack = twosingletonesNOUP(stack, 7, 1.0, 0, 3.14159e6,     1.0, 0, 22/7*1e6 );
% set these individually : 
stack = onesingletone(stack, 0, 7, 1.0,  0, 3.14159e6);
stack = onesingletone(stack, 1, 7, 1.0,  0, 22/7 *1e6);
stack = flexupdateboth(stack);

% Send all instructions to the FIFO
stack = flexflush(t, stack);

% now change between profiles. 
% A Gray order is needed to switch between all profiles. Only 5/8
% transitions are allowed. 
% Ctrl - C in the command space to get out of this
while (1) 
    % set channel 0/1/both to profile 0-7
                        % both to 0
    stack = setprof(stack, 2, 0);
    stack = flexflush(t, stack);
    pause(5);
                     % ch 1 to prof 1
    stack = setprof(stack, 1, 1);
    stack = flexflush(t, stack);
    pause(1);        % ch 0 to prof 1...etc
    stack = setprof(stack, 0, 1);
    stack = flexflush(t, stack);
    pause(1);
    
    stack = setprof(stack, 0, 7);
    stack = flexflush(t, stack);
    pause(1);
    stack = setprof(stack, 1, 7);
    stack = flexflush(t, stack);
    pause(1);

    stack = setprof(stack, 2, 1);
    stack = flexflush(t, stack);
    pause(1.5);
    
    stack = setprof(stack, 2, 7);
    stack = flexflush(t, stack);
    pause(1.5);

end
