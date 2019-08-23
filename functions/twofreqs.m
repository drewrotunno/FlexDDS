function twofreqs(t, prof, freqHz1, freqHz2)


flexsnd(t,['dcp 0 spi:STP',num2str(prof),'=0x',amp2ASF(1),phase2powdeg(0),freq2ftw(freqHz1)])
flexsnd(t,['dcp 1 spi:STP',num2str(prof),'=0x',amp2ASF(1),phase2powdeg(0),freq2ftw(freqHz2)])
setprof(t,prof);
flexupdateboth(t)

end

