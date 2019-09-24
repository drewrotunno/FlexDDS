function stack = twosingletones(stack, prof, amp1,  phase1, freqHz1, amp2, phase2, freqHz2)
% TWOSINGLETONES 
% for amplitude, need to allowampl() separately, didn't want to put it hard
% here to pass in last CFR

stack = flexstack(stack,['dcp 0 spi:STP',num2str(prof),'=0x',amp2ASF(amp1),phase2powdeg(phase1),freq2ftw(freqHz1)]);
stack = flexstack(stack,['dcp 1 spi:STP',num2str(prof),'=0x',amp2ASF(amp2),phase2powdeg(phase2),freq2ftw(freqHz2)]);
stack = flexstack(stack,['dcp update:=',num2str(prof),'p']);
% stack = flexupdateboth(stack);

end

