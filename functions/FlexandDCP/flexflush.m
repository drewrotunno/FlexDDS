function flexflush(t, stack)

str2send = '';
for c = 1:1:size(stack,2)
%     disp(stack{c});
    str2send = [str2send,stack{c},'\n'];
end

flexsnd(t,str2send);

% flexlst(t);

end
