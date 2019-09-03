
%   [a,b,c]=onerampphase(t,0, 0,360-.001, 4, .5)

%   start 0 phase
%   end shy of 260
%   every 4 ns (clock min)
%   change .5 deg


waitforRackA(t,0);
pulseB(t,100);
rampup(t,0)
waitforRackA(t,0);
pulseB(t,100);
rampdown(t,0)