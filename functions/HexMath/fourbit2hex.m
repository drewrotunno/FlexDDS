function [hexchar] = fourbit2hex(inarray)
%FOURBIT2HEX turns a four bit array into its hex representation

if( size(inarray,2) == 4 ) %disp('size is right') 
else disp('size is WRONG'); return; end
if( all(inarray== 1 | inarray== 0) ) % disp('digits are fine') 
else disp('only 1s and 0s plz'); return; end

if(     inarray == [1,1,1,1] ) 
    hexchar = 'f';
elseif( inarray == [1,1,1,0] ) 
    hexchar = 'e';
elseif( inarray == [1,1,0,1] ) 
    hexchar = 'd';
elseif( inarray == [1,1,0,0] ) 
    hexchar = 'c';
elseif( inarray == [1,0,1,1] ) 
    hexchar = 'b';
elseif( inarray == [1,0,1,0] ) 
    hexchar = 'a';
elseif( inarray == [1,0,0,1] ) 
    hexchar = '9';
elseif( inarray == [1,0,0,0] ) 
    hexchar = '8';
elseif( inarray == [0,1,1,1] ) 
    hexchar = '7';
elseif( inarray == [0,1,1,0] ) 
    hexchar = '6';
elseif( inarray == [0,1,0,1] ) 
    hexchar = '5';
elseif( inarray == [0,1,0,0] ) 
    hexchar = '4';
elseif( inarray == [0,0,1,1] ) 
    hexchar = '3';
elseif( inarray == [0,0,1,0] ) 
    hexchar = '2';
elseif( inarray == [0,0,0,1] ) 
    hexchar = '1';
elseif( inarray == [0,0,0,0] ) 
    hexchar = '0';
end


end

