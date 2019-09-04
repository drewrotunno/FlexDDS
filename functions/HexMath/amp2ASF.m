function [ampword] = amp2ASF(ampin)

amp = ampin*2^14-1;

amp = max(amp,0);
amp = min(amp,2^14-1);


ampword = dec2hex(round(amp),4);

end

