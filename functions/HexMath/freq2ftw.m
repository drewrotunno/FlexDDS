function [ftw] = freq2ftw(freq)
%FREQ2FTW Turns Hz frequency into the frequency tuning word

clock = 1e9;

bits = 2^32;

% ftw = dec2hex(round(bits*freq/clock),8);      %haha i made my own
ftw = uint2hex(uint32(round(bits*freq/clock)));

end

