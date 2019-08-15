function [t] = openconn()

% test script for talking to the Flex DDS

ip = '192.168.0.45';
port = 26000;

password = '75f4a4e10dd4b6b0';

t = tcpip(ip,port);
fopen(t);

fprintf(t,password);

if(t.BytesAvailable)
fscanf(t)
end
pause(.1);
flexlst(t)

end

