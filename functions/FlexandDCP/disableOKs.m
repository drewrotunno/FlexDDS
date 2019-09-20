function disableOKs(t)
%disableOKs - ask DCP to stop sending OK's

flexsnd(t, 'set resp_suppress_ok=1')

end

