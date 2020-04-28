function test(xyzs)

dd = length(xyzs(1,:));



% checking the input time vector

% Check whether t is in order (i.e., monotonically increasing)
% Can delete this code
t = xyzs(:,dd);
st = circshift(t,1);
st = t(2:end) - st(2:end);
w = find(st > 0); 
z = length(w);
z = z +1;


if  issorted(t, 'ascend') == 0
    disp('The time vector is not in order')
    return
end

% Tests to make sure not all frames are the same (i.e., that we have some
% time span)
% w is the list of indices of unique values of t offset by one (i.e., t(w)
% = unique(t) with the last value of unique(t) cut off).
% This means z is the number of unique values of t
[uq_t, indices] = unique(t);

indices = indices - 1;
indices = indices(2:end);
isequal(w,indices)

len_uq_t = length(uq_t);