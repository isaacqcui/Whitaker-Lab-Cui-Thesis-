%Returns the instantaneous velocites for a single seed
%imput a single seed in format xyt
%n is the number of data points velocity is averaged over
function velocities = findVelocities(track,n)
if nargin < 2
    n = 1;
end
%Find Displacements
xDisplacements = track((1+n):end,1)-track(1:end-n,1);
yDisplacements = track((1+n):end,2)-track(1:end-n,2);
tDisplacements = track((1+n):end,3)-track(1:end-n,3);
%whos xDisplacements
%Find Velocities
xVelocities = xDisplacements ./ tDisplacements;
yVelocities = yDisplacements ./ tDisplacements;
timePoints = track(1:end-n,3);
%Return velocity vectors in format Vx,Vy,t
velocities = [xVelocities,yVelocities,timePoints];
%whos velocities
end