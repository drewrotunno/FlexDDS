function [] = flexupdateboth(t)

flexsnd(t,'dcp update:u')


 pause(.1);
flexlst(t);
end

