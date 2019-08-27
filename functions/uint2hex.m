function [hexout] = uint2hex(numin)
%UINT2HEX turns a uint to a hex. 


intp = class(numin);
if( strcmp(intp, 'uint8') ||strcmp(intp, 'uint16') ||strcmp(intp, 'uint32') ||strcmp(intp, 'uint64') )  numwork = numin;
else    disp('not a uint, idk what to do'); return; end

switch intp
    case 'uint8'
        numbits = 8;
        numhexdig = numbits/4;
        hexdig = cell(1,numhexdig);
        outwork = zeros(1,numbits);
        for p = numbits-1:-1:0
            if( numwork >= 2^p )
                outwork(numbits-p) = 1;
                numwork = numwork - 2^p;
            else
                outwork(numbits-p) = 0;   % redundant, established as zeros
            end
        end
        
        for h = 1:1:numhexdig
            hexout(h) = fourbit2hex(outwork(h*4-3:h*4));
        end
      
    case 'uint16'
        numbits = 16;
        numhexdig = numbits/4;
        hexdig = cell(1,numhexdig);
        outwork = zeros(1,numbits);
        for p = numbits-1:-1:0
            if( numwork >= 2^p )
                outwork(numbits-p) = 1;
                numwork = numwork - 2^p;
            else
                outwork(numbits-p) = 0;   % redundant, established as zeros
            end
        end
        
        for h = 1:1:numhexdig
            hexout(h) = fourbit2hex(outwork(h*4-3:h*4));
        end

    case 'uint32'
        numbits = 32;
        numhexdig = numbits/4;
        hexdig = cell(1,numhexdig);
        outwork = zeros(1,numbits);
        for p = numbits-1:-1:0
            if( numwork >= 2^p )
                outwork(numbits-p) = 1;
                numwork = numwork - 2^p;
            else
                outwork(numbits-p) = 0;   % redundant, established as zeros
            end
        end
        
        for h = 1:1:numhexdig
            hexout(h) = fourbit2hex(outwork(h*4-3:h*4));
        end

    case 'uint64'
        numbits = 64;
        numhexdig = numbits/4;
        hexdig = cell(1,numhexdig);
        outwork = zeros(1,numbits);
        for p = numbits-1:-1:0
            if( numwork >= 2^p )
                outwork(numbits-p) = 1;
                numwork = numwork - 2^p;
            else
                outwork(numbits-p) = 0;   % redundant, established as zeros
            end
        end
        
        for h = 1:1:numhexdig
            hexout(h) = fourbit2hex(outwork(h*4-3:h*4));
        end

end

