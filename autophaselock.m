function autophaselock(t, num)


switch num
    case 1      % set
        % sets bit 13='Autoclear phase accumulator'  in CFR1 to LOW
        %       will set phase to 0 on every update. --Bad? --
        flexsnd(t,'dcp spi:CFR1=0x00412002')
        flexupdateboth(t)

    case 2
        % sets bit 13='Autoclear phase accumulator'  in CFR1 to LOW
        %       will set phase to 0 on every update. --Bad? --
        flexsnd(t,'dcp spi:CFR1=0x00410002')
        flexupdateboth(t)
end
end

