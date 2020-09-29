% I hope this is a good guide for sample session. 
clear all;

[t2, stack2] =openconn('192.168.0.45', 1);
%               amp/phase/freq ...  -chan 0------      -chan 1------
stack2 = twosingletonesNOUP(stack2, 0, 1.0, 0, 100e6,     1.0, 0, 100e6);
stack2 = flexupdateboth(stack2);
stack2 = flexflush(t1, stack2);
fclose('all');