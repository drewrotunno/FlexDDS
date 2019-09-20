function stack = twofreqs(stack, prof, freqHz1, freqHz2)


stack = flexstack(stack,['dcp 0 spi:STP',num2str(prof),'=0x',amp2ASF(1),phase2powdeg(0),freq2ftw(freqHz1)]);
stack = flexstack(stack,['dcp 1 spi:STP',num2str(prof),'=0x',amp2ASF(1),phase2powdeg(0),freq2ftw(freqHz2)]);
stack = setprof(stack,prof);
stack = flexupdateboth(stack);

end

