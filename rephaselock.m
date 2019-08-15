function rephaselock(t)

% sets bit 11='Clear Phase Accumulator'  in CFR1 to high 
flexsnd(t,'dcp spi:CFR1=0x00410802')
flexupdateboth(t)

% sets bit 11='Clear Phase Accumulator'  in CFR1 to low (back to normal)
flexsnd(t,'dcp spi:CFR1=0x00410002')
flexupdateboth(t)

end

