function stack = phasediffsamefreq(stack, phasediffdeg, freqHz)

stack = flexstack(stack,['dcp 0 spi:STP0=','0x',amp2ASF(1),phase2powdeg(0),freq2ftw(freqHz)]);
stack = flexstack(stack,['dcp 1 spi:STP0=','0x',amp2ASF(1),phase2powdeg(phasediffdeg),freq2ftw(freqHz)]);
stack = setprof(stack,0);
stack = flexupdateboth(stack);

end

