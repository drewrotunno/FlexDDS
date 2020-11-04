function stack = multifreqtime_OLD(stack, chan, freqlist, timelist, knownCFR)

numramps = numel(timelist);

if ~( numel(timelist) == numel(freqlist)-1)
    disp('Wrong number of times / frequencies. Want NumFreqs = NumTimes+1'); return
end
error    = 1e-3;   % or whatever
maxword  = 100;      % 400 ns or 23 Hz

if freqlist(1) > freqlist(2);   mirror = 1;
else;                           mirror =0; end
% Generate all the ramp numbers
for r = 1:1:numramps 
    tsteptot = round((timelist(r).*1e9)./4);
    freqstart = freqlist(r);
    freqend   = freqlist(r+1);
    if freqstart > freqend      % high to low
        if mirror
            lowftw = freq2ftwM(freqstart); highftw = freq2ftwM(freqend);
        else
            lowftw  = freq2ftw(freqend); highftw = freq2ftw(freqstart);
        end
        isup(r) = 0;   
    elseif freqstart < freqend  %low to high (normal) 
        if mirror
            lowftw  = freq2ftwM(freqend); highftw = freq2ftwM(freqstart);
        else
            lowftw  = freq2ftw(freqstart); highftw = freq2ftw(freqend);
        end
        isup(r) = 1;
    end
    fsteptot = hex2uint32(highftw)-hex2uint32(lowftw);
    % make num the larger value, proper fraction: num/den
    if fsteptot > tsteptot      % slope > 1, 
        num = double(fsteptot); den = double(tsteptot);
    elseif fsteptot <= tsteptot  % slope < 1
        num = double(tsteptot);den = double(fsteptot);
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
    if fsteptot > tsteptot
        freqword = uint32( round( other*num/den) ); timeword = uint16( other );
        freqstep = round(other*num/den)*1e9/2^32;   timestep(r) = other*4e-9;
    else 
        timeword = uint16( round( other*num/den));  freqword = uint32( other );
        freqstep = other*1e9/2^32;        timestep(r) = round(other*num/den)*4e-9;
    end

    DRL{r}  = [highftw, lowftw];
    DRSS{r} = [uint2hex( freqword ) , uint2hex( freqword ) ];
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
            if isup(r-1) && isup(r)         %up then up
                if mirror 
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{old}(1:8), DRL{r}(9:16)]);
                else
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                end
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);    stack = flexupdateboth(stack);  
                % stack = togglerampdir(stack,2); %already same
%                 stack = pulseB(stack,150);  %intended for debug 
            elseif isup(r-1) && ~isup(r)     %up then down
                old = r-1;
                if mirror 
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                else
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{old}(1:8), DRL{r}(9:16)]);
                end
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);    
                stack = flexupdateboth(stack);
                stack = togglerampdir(stack,2); %has to change
%                 stack = pulseB(stack,150);         %intended for debug  
            elseif ~isup(r-1) && isup(r)     %down then up
                old = r-1;
                if mirror 
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{old}(1:8), DRL{r}(9:16)]);
                else
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}(1:8), DRL{old}(9:16)]);
                end
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);    stack = flexupdateboth(stack);
                stack = togglerampdir(stack,2); %has to change
%                 stack = pulseB(stack,150);          %intended for debug 
            elseif ~isup(r-1) && ~isup(r)     %down then down
% This one is special. Re-limiting will snap to the new lower limit. 
% instead, step up one step, then down after
              % down then up - copied
              % limit: one step above
%               if isup(r-2)
%                   old = r-2;
%               end
                if mirror 
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{old}(1:8),uint2hex(hex2uint32(DRL{r}(9:16)) + 1)]);
                else
                    stack = flexstack(stack,['dcp spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{old}(9:16)]);
                end
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
                if mirror 
                    stack = flexstack(stack,['dcp spi:DRL=0x',DRL{r}(1:8), uint2hex(hex2uint32(DRL{r}(9:16)) + 1)]);
                else
                    stack = flexstack(stack,['dcp spi:DRL=0x',uint2hex(hex2uint32(DRL{r}(1:8)) + 1), DRL{r}(9:16)]);
                end
                stack = flexstack(stack,['dcp spi:DRSS=0x',DRSS{r}]);
                stack = flexstack(stack,['dcp spi:DRR=0x',DRR{r}]);
                stack = waitforRackA(stack,2);
                stack = flexupdateboth(stack);
                stack = togglerampdir(stack,2); %has to change
%                 stack = pulseB(stack,150);         %intended for debug  
            end
        end
        end

end