function [hexout] = binVec2Hex(binvec)
% return a string of hex's for a binary vector input
% use to be a daq tool box but my bad i'll just write it

% these should only be 32 bits = 4b/h * 8 hex digits
for h=1:1:8
    hexout(h) = fourbit2hex(binvec( (h-1)*4+1 : 4*h ) );   
end

end

