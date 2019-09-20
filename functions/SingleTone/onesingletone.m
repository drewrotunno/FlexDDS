function stack = onesingletone(stack, chan, prof, amp1,  phase, freqHz)
% 

stack = flexstack(stack,['dcp ', num2str(chan),' spi:STP',num2str(prof),'=0x',amp2ASF(amp1),phase2powdeg(phase),freq2ftw(freqHz)]);
stack = flexstack(stack,['dcp ', num2str(chan),' update:=',num2str(prof),'p']);


end

