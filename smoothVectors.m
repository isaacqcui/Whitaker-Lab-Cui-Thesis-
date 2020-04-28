function smoothedVec = smoothVectors(x,n)
% Takes in a vector a returns a smoothed version of it. Algorithm takes
% number of steps (n) and returns a vector where each value is the average 
% of the 2n values around an entry of the original vector averaged.
len = size(x);
smoothedVec = zeros(len(1)-2*n, 1);
for i = 1:(len(1)-2*n)
   smoothedVec(i) = sum(x(i:(i+2*n)))/(2*n+1); 
end
end

%Finish smoothing algorithm, input this into runAnalysis, compare that
%smoothing with previous smoothing algorithm, and then apply it to the size