function [ outint ] = hex2uint64( inhex )
%HEX2UINT32 turn 8 hex digits into a 32 bit unsigned integer

numbindig = 64;
numhexdig = numbindig/4;
outint =uint64(0);
inhex=strrep(inhex, '0x', '');
if( class(inhex) ~= 'char' ) disp('typre is wrong - must be char array in'); return; end
if( size(inhex,2)  ~= numhexdig ) disp('size is WRONG'); return; end

outwork = zeros(1,numbindig);
% hex to binary vector
for h = 1:1:numhexdig
    outwork(h*4-3:h*4) = hex2fourbit(inhex(h));
end
%binary vector to interger
for d = 1:1:numbindig
    power = numbindig-d;
    outint = outint + outwork(d)*(2^(power));
end

end

