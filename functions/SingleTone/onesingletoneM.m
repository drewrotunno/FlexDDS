function stack = onesingletoneM(stack, chan, prof, amp1,  phase, freqHz)
% 

stack = flexstack(stack,['dcp ', num2str(chan),' spi:STP',num2str(prof),'=0x',amp2ASF(amp1),phase2powdeg(phase),freq2ftwM(freqHz)]);
stack = flexstack(stack,['dcp ', num2str(chan),' update:=',num2str(prof),'p']);


end

