%% testing ground for commands


% t=openconn();

flexsnd(t,'dcp 0 spi:stp0=0x3fff000033333333');
flexsnd(t,'dcp 1 spi:stp0=0x3fff000033333333');
flexsnd(t,'dcp update:u');
% flexlst(t);
flexsnd(t,'dcp 0 spi:stp0=0x3fff7fff33333333');
flexsnd(t,'dcp 1 spi:stp0=0x3fff000033333333');
% flexsnd(t,'dcp wait:20000:');
% flexlst(t);
flexsnd(t,'dcp wait::15');
flexsnd(t,'dcp update:u');
flexlst(t);

