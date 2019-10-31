% these live scripts have not been adapted to the new stack/flush system. 
% Function calls need the variable 
% stack = {''};
% then using 
% stack = function(stack, ...);
% to return the variable one command longer. You could preallocate this? 
% and finally flushing. These live commands require code saved as a release in this Gitbhub repo. 
% https://github.com/drewrotunno/FlexDDS/releases

stack = function( {''}, ..., )
% test script for talking to the Flex DDS

%% OLD, simple test for DHCP assigning at .100 by default

ip = '192.168.0.100';
port = 26000;


password = '75f4a4e10dd4b6b0';

t = tcpip(ip,port);
fopen(t);

fprintf(t,password)

fscanf(t)

