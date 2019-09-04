function [phaseword] = phase2powdeg(inphase)
%FREQ2FTW Turns Hz frequency into the frequency tuning word

twopi = 360;

bits = 2^16;

phase = mod(inphase,twopi);

phaseword = dec2hex(round(phase*bits/twopi),4);

end

