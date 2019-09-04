function twosingletonesNOUP(t, prof, amp1,  phase1, freqHz1, amp2, phase2, freqHz2)
% TWOSINGLETONES 
% for amplitude, need to allowampl() separately, didn't want to put it hard
% here to pass in last CFR

if nargin==8

flexsnd(t,['dcp update:=',num2str(prof),'p']);
flexsnd(t,['dcp 0 spi:STP',num2str(prof),'=0x',amp2ASF(amp1),phase2powdeg(phase1),freq2ftw(freqHz1)])
flexsnd(t,['dcp 1 spi:STP',num2str(prof),'=0x',amp2ASF(amp2),phase2powdeg(phase2),freq2ftw(freqHz2)])

% flexupdateboth(t);
% just do both at once ^
% flexupdateboth(t)
% setprof(t,prof);

else
    disp('sorry bro, need the right arguments');
end

end

