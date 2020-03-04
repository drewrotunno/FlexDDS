% Double-check phase alignment between different slots using a Rack trigger

clear all;
numslots = 2;

for s = 1:1:numslots
    % Establish a connection to the FlexDDS via IP + slot#
    % Store values in index s for each slot in a cell array
    [t{s}, stack{s}] =openconn('192.168.0.45', s-1);
    % grab the default CFR values on both channels, reset them to default. 
    [knownCFR{s}, stack{s}] = resetCFR(stack{s},2);

    % Phase lock on Rack A
    [knownCFR{s}, stack{s}] = setClearPhaseAccum(stack{s}, 2, 1, knownCFR{s});
    stack{s} = flexupdateboth(stack{s});
    [knownCFR{s}, stack{s}]= setClearPhaseAccum(stack{s}, 2, 0, knownCFR{s});
    stack{s} = waitforRackA(stack{s},2);
    stack{s} = flexupdateboth(stack{s});

    % Give each slot a different relative phase
    switch s
        case 0
        stack{s} = onesingletone(stack{s}, 0, 0, 1.0,  0, 5e6);
        case 1
        stack{s} = onesingletone(stack{s}, 0, 0, 1.0,  180, 5e6);
    end
    stack{s} = flexupdateboth(stack{s});

    % Send it
    stack{s} = flexflush(t{s}, stack{s});

end

% Seems to work! 