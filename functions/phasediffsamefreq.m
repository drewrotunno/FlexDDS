function phasediffsamefreq(t, phasediffdeg, freqHz)

flexsnd(t,['dcp 0 spi:STP0=','0x',ampscale(1),phase2powdeg(0),freq2ftw(freqHz)])
flexsnd(t,['dcp 1 spi:STP0=','0x',ampscale(1),phase2powdeg(phasediffdeg),freq2ftw(freqHz)])
setprof(t,0);
flexupdateboth(t)

end

