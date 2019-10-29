%%% FIXED - outputs should be phase- and freq- continuous. 
% This one took a bit of time. To ramp between arbitrary frequencies
% the trick is to change one limit at a time. Changing both throws a wrench
% in the works and jumps to the end of subsequent ramps. For example,
% ramping 10 to 20 to 30, if one updates the ramp limits to 20 and 30 after
% the first sweep, the frequency output will jump directly to 30 on
% IOupdate. Rather, if we only change the upper ramp limit, it will
% continue up as expected. Mirrors swap high and low words for frequency.
% The bulk of this is in multifreqtime() and multifreqnoDD().
% This is designed for use where there's a constant phase difference
% between two channels, sweeping at the same frequency as eachother. Thanks
% to Weisers for the good deterministic timing on both channels! 

% downs the ups
% freqlist   = [45,35, 25, 15, 25, 35, 50] .*1e6 ;
% timelist = [ .5, .5, .5, .5 , .5, .5 ] ;

% up down down down 
freqlist   = [70, 95, 35, 30, 35,25,5] .*1e6 ;
timelist = [ .5, 2.5, 2.5, .5, 2.75, 2.75, ] ;

%updown updown
% freqlist   = [ 10,20,11,21,12,22,13] .*1e6 ;
% timelist = [  .5, .5, .5 , .5, .5, .5 ] ;

%down up down up
% freqlist   = [ 20,11,21,12,22,13, 20] .*1e6 ;
% timelist = [  .5, .5, .5 , .5, .5, .5 ] ;

%normal use
% freqlist   = [ 3,8,3] .*1e6 ;
% timelist = [  .5, .5] ;

phase       = 180; 

% Establish a connection to the FlexDDS via IP + slot#
[t, stack] =openconn('192.168.0.45', 0);
[knownCFR, stack] = resetCFR(stack,2);

stack = rampdown(stack,2);
stack = stophold(stack,2);

[knownCFR, stack] = setDRGFreq(  stack, 2, knownCFR);
[knownCFR, stack] = setDRGEnable(stack, 2, 1, knownCFR);


if freqlist(1) < freqlist(2)
    stack = twosingletones(stack, 0, 1, 0, freqlist(1), 1, phase, freqlist(1));
else
    stack = twosingletonesM(stack, 0, 1, 0, freqlist(1), 1, 360-phase, freqlist(1));
end

[knownCFR, stack] = setClearPhaseAccum(stack, 2, 1, knownCFR);
[knownCFR, stack] = setClearDRGAccum(stack, 2, 1, knownCFR);
stack = flexupdateboth(stack);

[knownCFR, stack]= setClearPhaseAccum(stack, 2, 0, knownCFR);
[knownCFR, stack] = setClearDRGAccum(stack, 2, 0, knownCFR);
stack = waitforRackA(stack,2);
stack = flexupdateboth(stack);

% all the action is in this function
stack  = multifreqtime(stack,2,freqlist,timelist, knownCFR);

% Works, but can't do down then down ramps. 
% stack  = multifreqnoDD(stack,2,freqlist,timelist, knownCFR);

% stack'

stack = flexflush(t, stack);




