function enableOKs(t)
%enableOKs - ask DCP to stop sending OK's

flexsnd(t, 'set resp_suppress_ok=0')


end

