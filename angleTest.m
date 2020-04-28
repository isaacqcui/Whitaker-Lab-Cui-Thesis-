function angleTest(metricSeedTrack,startN,endN, SeedName)

Angles  = zeros(endN-startN+1, 2);

for n = 0:endN-startN
    
Angles(n+1, 1) = startN+n;
    
velocitiesRawInstant = findVelocities(metricSeedTrack,1);
velocities = findVelocities(metricSeedTrack,n+startN);

theta = rad2deg(atan(velocities(1,2)/velocities(1,1)));
    %theta = mod(theta,180);
    
    if theta < 0
        Angles(n+1, 2) = theta + 180;
        
    else
        Angles(n+1, 2) = theta;
    end
    
figure
plot((startN: endN), Angles(:,2));
title(SeedName)




end

    
