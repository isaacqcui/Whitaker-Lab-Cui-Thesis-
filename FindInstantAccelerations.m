
%Returns extimated instance accelerations for each time point
%Use a quadradic fit for the n data points after each time to make the
%estimate

function accelerations = FindInstantAccelerations(metricTrack, n)
%Determine the number of timepoints the output acceleration table will have
N = size(metricTrack,1)-(2*n);
%Prealocate space for acceleration matrix
accelerations = zeros(N,3);
accelerations(:,3) = metricTrack(1:N,3);
for i = 1:N
    smallTrack = metricTrack(i:i+2*n,:);
    accelerations(i,1:2) = FindAverageAcceleration(smallTrack);
end
end