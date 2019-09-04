function newCFR = autophaselock(t, chan, setbit, lastCFR)


        newCFR = setCFRbit(t,chan,1,13,setbit,lastCFR);


        % sets bit 13='Autoclear phase accumulator'  in CFR1 to LOW
        %       will set phase to 0 on every update. --Bad? --
%         flexsnd(t,'dcp spi:CFR1=0x00412002')
%         flexupdateboth(t)

        % sets bit 13='Autoclear phase accumulator'  in CFR1 to LOW
        %       will set phase to 0 on every update. --Bad? --
%         flexsnd(t,'dcp spi:CFR1=0x00410002')
%         flexupdateboth(t)

end

