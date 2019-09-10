function [out] = flexlst(t)


if(~t.BytesAvailable)
    out = 'nothing yet';
    disp('nothing yet');
else
    while(t.BytesAvailable)
        out = deblank(fscanf(t));
%         disp(out)
%         if(~strcmp(deblank(fscanf(t)), 'OK'))
%             disp('something bad happened. NOT OK');
%         end    
    end
    return;
end
% 
% %wait a bit if needed
% timeout = .1;
% tic
% while(~t.BytesAvailable && toc<timeout)
% end
%     
% while(t.BytesAvailable)
%     disp(deblank(fscanf(t)))
%     if(~strcmp(deblank(fscanf(t)), 'OK'))
%         disp('something bad happened. NOT OK');
%     end
% end


end