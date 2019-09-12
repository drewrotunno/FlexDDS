function onesingletone(t, chan, prof, amp1,  phase, freqHz)
% 

flexsnd(t,['dcp ', num2str(chan),' spi:STP',num2str(prof),'=0x',amp2ASF(amp1),phase2powdeg(phase),freq2ftw(freqHz)])
flexsnd(t,['dcp ', num2str(chan),' update:=',num2str(prof),'p']);
% flexupdateone(t,chan);


end

