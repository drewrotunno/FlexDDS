function [outarray] = hex2fourbit(inhex)
%FOURBIT2HEX turns a hex digit into a four bit array

if( size(inhex,2) == 1 ) %disp('size is right') 
else disp('size is WRONG'); return; end
if( ismember(inhex, '0123456789abcdef') ) % disp('digits are fine')
else disp('not a hex digit!'); return; end

if(     inhex == 'f' ) 
    outarray = [1,1,1,1];
elseif( inhex == 'e' ) 
    outarray = [1,1,1,0];
elseif( inhex == 'd' ) 
    outarray = [1,1,0,1];
elseif( inhex == 'c' ) 
    outarray = [1,1,0,0];
elseif( inhex == 'b') 
    outarray = [1,0,1,1] ;
elseif( inhex == 'a' ) 
    outarray = [1,0,1,0];
elseif( inhex == '9' ) 
    outarray = [1,0,0,1];
elseif( inhex == '8' ) 
    outarray = [1,0,0,0];
elseif( inhex == '7' ) 
    outarray = [0,1,1,1];
elseif( inhex == '6' ) 
    outarray = [0,1,1,0];
elseif( inhex == '5' ) 
    outarray = [0,1,0,1];
elseif( inhex == '4' ) 
    outarray = [0,1,0,0];
elseif( inhex == '3' ) 
    outarray = [0,0,1,1];
elseif( inhex == '2' ) 
    outarray = [0,0,1,0];
elseif( inhex == '1' ) 
    outarray = [0,0,0,1];
elseif( inhex == '0' ) 
    outarray = [0,0,0,0];
end


end

