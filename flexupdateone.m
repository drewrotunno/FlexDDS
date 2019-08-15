function [] = flexupdateone(t, num)

flexsnd(t,['dcp ',num2str(num),' update:u']);

pause(.1);
flexlst(t);
end

