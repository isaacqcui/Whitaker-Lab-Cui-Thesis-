%Returns the instantaneous velocites for a single seed
%imput a single seed in format xyt
%n is the number of data points velocity is averaged over
function velocities = findVelocities_new(track,n)
%Find Displacements
xDisplacements = track(2:end,1)-track(1:end-1,1);
%whos xDisplacements
yDisplacements = track(2:end,2)-track(1:end-1,2);
tDisplacements = track(2:end,3)-track(1:end-1,3);

xVelocities = xDisplacements ./ tDisplacements;
yVelocities = yDisplacements ./ tDisplacements;

xVelocities = smoothVectors(xVelocities, n);
%whos xVelocities
yVelocities = smoothVectors(yVelocities, n);
%whos yVelocities
timePoints = track((n+1):(end-n-1),3);
%whos timePoints

%Return velocity vectors in format Vx,Vy,t
velocities = [xVelocities,yVelocities,timePoints];
%whos velocities
end