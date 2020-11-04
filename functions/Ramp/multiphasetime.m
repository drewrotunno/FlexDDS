function stack = multiphasetime(stack, chan, phaselist, timelist)

numramps = numel(timelist);

if ~( numel(timelist) == numel(phaselist)-1)
    disp('Wrong number of times / frequencies. Want NumFreqs = NumTimes+1'); return
end
if phaselist(2) > phaselist(1)
    disp('the first phase sweep should be up. make up a fake one if you have to. '); return
end

error    = 1e-3;   % or whatever
maxword  = 100;      % 400 ns or 23 Hz

% Generate all the ramp numbers
for r = 1:1:numramps 
    tsteptot = round((timelist(r).*1e9)./4);
    phasestart = phaselist(r);
    phaseend   = phaselist(r+1);
    if phasestart > phaseend      % high to low
        lowphase  = phase2powdeg(phaseend); highphase = phase2powdeg(phasestart);
        isup(r) = 0;   
    elseif phasestart < phaseend  %low to high (normal) 
        lowphase  = phase2powdeg(phasestart); highphase = phase2powdeg(phaseend);
        isup(r) = 1;
    elseif phasestart == phaseend  
        lowphase  = phase2powdeg(phasestart); highphase = phase2powdeg(phaseend);
        isup(r) = 2;
    end
    psteptot = hex2uint16(highphase)-hex2uint16(lowphase);
    % make num the larger value, proper fraction: num/den
    if psteptot > tsteptot      % slope > 1, 
        num = double(psteptot); den = double(tsteptot);
    elseif psteptot <= tsteptot  % slope < 1
        num = double(tsteptot);den = double(psteptot);
    end
    slope = num/den;other = 1;
    % how far from one is the slope? 
    diffq = abs( (slope - round(slope)) / slope) ;
    while diffq > error
        diff = abs(slope-round(slope));
        q = round(1/diff);
        slope = slope*q;
        if(other*q > maxword) ; break ; 
        else; other = other*q; end
        diffq = abs( (slope - round(slope)) / slope) ;
    end
    if psteptot > tsteptot
        phaseword = uint16( round( other*num/den) ); timeword = uint16( other );
%         phasestep = rad2deg(round(other*num/den)/2^16);   timestep(r) = other*4e-9;
    else 
        timeword = uint16( round( other*num/den));  phaseword = uint16( other );
%         phasestep = rad2deg(other/2^16);        timestep(r) = round(other*num/den)*4e-9;
    end

    DRL{r}  = [[highphase,'0000'], [lowphase,'0000']];
    DRSS{r} = [[uint2hex( phaseword ),'0000'] , [uint2hex( phaseword ),'0000'] ];
    DRR{r}  = [uint2hex( timeword ) , uint2hex( timeword ) ];

end
% can print these to debug
% isup'
% DRL'
% DRSS'
% DRR'

% send that shit
switch chan
    case 2
    for r=1:1:numramps 
        if r==1
            stack = rampdown(stack,2);    % for safety
            stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}]);
            stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
            stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
            stack = flexupdateboth(stack);
            stack = waitforRackA(stack,2); stack = rampup(stack,2); 
%             stack = pulseB(stack,150);  %intended for debug 
            old = r;
        else
            if isup(r) == 2                 %repeat
                stack = waitforRackA(stack,2); 
            elseif isup(r-1) && isup(r)         %up then up
                stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);    stack = flexupdateboth(stack);  
                stack = rampup(stack,2); 
%                 stack = pulseB(stack,150);  %intended for debug 
            elseif isup(r-1) && ~isup(r)     %up then down
                old = r-1;
                stack = flexstack(stack,['dcp spi:DRL=0x',DRL{old}(1:8), DRL{r}(9:16)]);
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);    
                stack = flexupdateboth(stack);
                stack = rampdown(stack,2); 
%                 stack = pulseB(stack,150);         %intended for debug  
            elseif ~isup(r-1) && isup(r)     %down then up
                old = r-1;
                stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);    stack = flexupdateboth(stack);
                stack = togglerampdir(stack,2); %has to change
                stack = rampup(stack,2); 
%                 stack = pulseB(stack,150);          %intended for debug 
            elseif ~isup(r-1) && ~isup(r)     %down then down
% This one is special. Re-limiting will snap to the new lower limit. 
% instead, step up one step, then down after
              % down then up - copied
              % limit: one step above
%               if isup(r-2)
%                   old = r-2;
%               end
                stack = flexstack(stack,['dcp spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{old}(9:16)]);
                    % one tiny step up: rate 1, step 1
                stack = flexstack(stack,'dcp spi:DRSS=0x0000000100000001');
                stack = flexstack(stack,'dcp spi:DRR=0x00010001');
%                 stack = waitforRackA(stack,2);
                stack = waitForEvent(stack,2,35);
                stack = flexupdateboth(stack);
                stack = togglerampdir(stack,2); %has to change
%                 stack = pulseB(stack,150);            %intended for debug 
                % end down then up

                %up then down
                old = r-1;
                stack = flexstack(stack,['dcp spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{r}(9:16)]);
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);
                stack = flexupdateboth(stack);
                stack = rampdown(stack,2); 
                
%                 stack = pulseB(stack,150);         %intended for debug  
            end
        end
    end
    case 1
    for r=1:1:numramps 
        if r==1
            stack = rampdown(stack,1);    % for safety
            stack = flexstack(stack,['dcp 1 spi:DRL=0x',DRL{r}]);
            stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS{r}]);
            stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR{r}]);
            stack = flexupdateboth(stack);
            stack = waitforRackA(stack,1); stack = rampup(stack,1); 
%             stack = pulseB(stack,150);  %intended for debug 
            old = r;
        else
            if isup(r) == 2                 %repeat
                stack = waitforRackA(stack,1); 
            elseif isup(r-1) && isup(r)         %up then up
                stack = flexstack(stack,['dcp 1 spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,1);    stack = flexupdateboth(stack);  
                stack = rampup(stack,1); 
%                 stack = pulseB(stack,150);  %intended for debug 
            elseif isup(r-1) && ~isup(r)     %up then down
                old = r-1;
                stack = flexstack(stack,['dcp 1 spi:DRL=0x',DRL{old}(1:8), DRL{r}(9:16)]);
                stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,1);    
                stack = flexupdateboth(stack);
                stack = rampdown(stack,1); 
%                 stack = pulseB(stack,150);         %intended for debug  
            elseif ~isup(r-1) && isup(r)     %down then up
                old = r-1;
                stack = flexstack(stack,['dcp 1 spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,1);    stack = flexupdateboth(stack);
                stack = togglerampdir(stack,1); %has to change
                stack = rampup(stack,1); 
%                 stack = pulseB(stack,150);          %intended for debug 
            elseif ~isup(r-1) && ~isup(r)     %down then down
% This one is special. Re-limiting will snap to the new lower limit. 
% instead, step up one step, then down after
              % down then up - copied
              % limit: one step above
%               if isup(r-2)
%                   old = r-2;
%               end
                stack = flexstack(stack,['dcp 1 spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{old}(9:16)]);
                    % one tiny step up: rate 1, step 1
                stack = flexstack(stack,'dcp 1 spi:DRSS=0x0000000100000001');
                stack = flexstack(stack,'dcp 1 spi:DRR=0x00010001');
%                 stack = waitforRackA(stack,1);
                stack = waitForEvent(stack,1,35);
                stack = flexupdateboth(stack);
                stack = togglerampdir(stack,1); %has to change
%                 stack = pulseB(stack,150);            %intended for debug 
                % end down then up

                %up then down
                old = r-1;
                stack = flexstack(stack,['dcp 1 spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{r}(9:16)]);
                stack = flexstack(stack,['dcp 1 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 1 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,1);
                stack = flexupdateboth(stack);
                stack = rampdown(stack,1); 
                
%                 stack = pulseB(stack,150);         %intended for debug  
            end
        end
    end
    case 0
    for r=1:1:numramps 
        if r==1
            stack = rampdown(stack,0);    % for safety
            stack = flexstack(stack,['dcp 0 spi:DRL=0x',DRL{r}]);
            stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS{r}]);
            stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR{r}]);
            stack = flexupdateboth(stack);
            stack = waitforRackA(stack,0); stack = rampup(stack,0); 
%             stack = pulseB(stack,150);  %intended for debug 
            old = r;
        else
            if isup(r) == 2                 %repeat
                stack = waitforRackA(stack,0); 
            elseif isup(r-1) && isup(r)         %up then up
                stack = flexstack(stack,['dcp 0 spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,0);    stack = flexupdateboth(stack);  
                stack = rampup(stack,0); 
%                 stack = pulseB(stack,150);  %intended for debug 
            elseif isup(r-1) && ~isup(r)     %up then down
                old = r-1;
                stack = flexstack(stack,['dcp 0 spi:DRL=0x',DRL{old}(1:8), DRL{r}(9:16)]);
                stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,0);    
                stack = flexupdateboth(stack);
                stack = rampdown(stack,0); 
%                 stack = pulseB(stack,150);         %intended for debug  
            elseif ~isup(r-1) && isup(r)     %down then up
                old = r-1;
                stack = flexstack(stack,['dcp 0 spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,0);    stack = flexupdateboth(stack);
                stack = togglerampdir(stack,0); %has to change
                stack = rampup(stack,0); 
%                 stack = pulseB(stack,150);          %intended for debug 
            elseif ~isup(r-1) && ~isup(r)     %down then down
% This one is special. Re-limiting will snap to the new lower limit. 
% instead, step up one step, then down after
              % down then up - copied
              % limit: one step above
%               if isup(r-2)
%                   old = r-2;
%               end
                stack = flexstack(stack,['dcp 0 spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{old}(9:16)]);
                    % one tiny step up: rate 1, step 1
                stack = flexstack(stack,'dcp 0 spi:DRSS=0x0000000100000001');
                stack = flexstack(stack,'dcp 0 spi:DRR=0x00010001');j
%                 stack = waitforRackA(stack,0);
                stack = waitForEvent(stack,0,35);
                stack = flexupdateboth(stack);
                stack = togglerampdir(stack,0); %has to change
%                 stack = pulseB(stack,150);            %intended for debug 
                % end down then up

                %up then down
                old = r-1;
                stack = flexstack(stack,['dcp 0 spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{r}(9:16)]);
                stack = flexstack(stack,['dcp 0 spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp 0 spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,0);
                stack = flexupdateboth(stack);
                stack = rampdown(stack,0); 
                
%                 stack = pulseB(stack,150);         %intended for debug  
            end
        end
    end
end