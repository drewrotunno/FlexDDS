function bin=hex2binstr(x)
hex=x;
for i=1:length(hex)
    if hex(i)=='f'
        bin((i*4)-3:i*4)=[1 1 1 1];
    elseif hex(i)=='e'
        bin((i*4)-3:i*4)=[1 1 1 0];
    elseif hex(i)=='d'
        bin((i*4)-3:i*4)=[1 1 0 1];
    elseif hex(i)=='c'
        bin((i*4)-3:i*4)=[1 1 0 0];
    elseif hex(i)=='b'
        bin((i*4)-3:i*4)=[1 0 1 1];
    elseif hex(i)=='a'
        bin((i*4)-3:i*4)=[1 0 1 0];
    elseif hex(i)=='F'
        bin((i*4)-3:i*4)=[1 1 1 1];
    elseif hex(i)=='E'
        bin((i*4)-3:i*4)=[1 1 1 0];
    elseif hex(i)=='D'
        bin((i*4)-3:i*4)=[1 1 0 1];
    elseif hex(i)=='C'
        bin((i*4)-3:i*4)=[1 1 0 0];
    elseif hex(i)=='B'
        bin((i*4)-3:i*4)=[1 0 1 1];
    elseif hex(i)=='A'
        bin((i*4)-3:i*4)=[1 0 1 0];
    elseif hex(i)=='9'
        bin((i*4)-3:i*4)=[1 0 0 1];
    elseif hex(i)=='8'
        bin((i*4)-3:i*4)=[1 0 0 0];
    elseif hex(i)=='7'
        bin((i*4)-3:i*4)=[0 1 1 1];
    elseif hex(i)=='6'
        bin((i*4)-3:i*4)=[0 1 1 0];
    elseif hex(i)=='5'
        bin((i*4)-3:i*4)=[0 1 0 1];
    elseif hex(i)=='4'
        bin((i*4)-3:i*4)=[0 1 0 0];
    elseif hex(i)=='3'
        bin((i*4)-3:i*4)=[0 0 1 1];
    elseif hex(i)=='2'
        bin((i*4)-3:i*4)=[0 0 1 0];
    elseif hex(i)=='1'
        bin((i*4)-3:i*4)=[0 0 0 1];
    elseif hex(i)=='0'
        bin((i*4)-3:i*4)=[0 0 0 0];
    end
end

bin = num2str(bin);
bin = bin(~isspace(bin));






% %%Copyright (c) 2009, Michael Chenoweth
% All rights reserved.
% https://www.mathworks.com/matlabcentral/fileexchange/24282-hexadecimal-to-binary
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
% 
% * Redistributions of source code must retain the above copyright notice, this
%   list of conditions and the following disclaimer.
% 
% * Redistributions in binary form must reproduce the above copyright notice,
%   this list of conditions and the following disclaimer in the documentation
%   and/or other materials provided with the distribution
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
