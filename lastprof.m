function lastprof(t)
% increment single tone profile number

flexsnd(t,'dcp update:-p');

while(~t.BytesAvailable)    
    % wait for ok's
end

% get those OK's
flexlst(t);

end

