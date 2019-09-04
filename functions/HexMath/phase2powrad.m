function [phaseword] = phase2powrad(inphase)
%FREQ2FTW Turns Hz frequency into the frequency tuning word

twopi = 2*pi;

bits = 2^16;

phase = mod(inphase,twopi);

phaseword = dec2hex(round(phase*bits/twopi),4);

end

