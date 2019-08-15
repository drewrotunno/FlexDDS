function [] = flexlst(t)

if(~t.BytesAvailable)
    disp('nothing for you buddy');
end
    
while(t.BytesAvailable)
    disp(deblank(fscanf(t)))
end


end

