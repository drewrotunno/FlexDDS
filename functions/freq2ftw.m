function [ftw] = freq2ftw(freq)
%FREQ2FTW Turns Hz frequency into the frequency tuning word

clock = 1e9;

bits = 2^32;

ftw = dec2hex(round(bits*freq/clock),8);
                                % min 8 digits
end

