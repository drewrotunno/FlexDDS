function [t] = openconn(ip,slot)

% test script for talking to the Flex DDS

% knownCFR = [['00410002'];['004008c0']];

% ip = '192.168.0.45';
port = 26000+slot;

password = ['75f4a4e10dd4b6b', num2str(slot)];

t = tcpip(ip,port, 'OutputBufferSize', uint32(2^31));
fopen(t);

fprintf(t,password);

% if(t.BytesAvailable)
% fscanf(t)
% end
pause(.1);
flexlst(t)

end

