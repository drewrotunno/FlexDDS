% test script for talking to the Flex DDS



ip = '192.168.0.100';
port = 26000;

password = '75f4a4e10dd4b6b0';

t = tcpip(ip,port);
fopen(t);

fprintf(t,password)

fscanf(t)

