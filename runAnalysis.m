function [launchAngle, averageSpeed, averageBallisticParameterDrag, averageBallisticParameterLift] = runAnalysis(metricSeedTrack, SeedName, numSmooth, mass, sizeTheory, plotsOn,saveOn)
    
 
    if nargin < 7
        saveOn = 0;
    end
    if nargin < 6
        plotsOn = 1;
    end
    if nargin < 2
        SeedName = 'Seed';
    end
    %number timesteps over which to calculate acceleration and velocity
    n = numSmooth;
    m = numSmooth;
    %n = 10;
    %m = 10;
    
    %Test plot of seedtrack
    if plotsOn
        figure;
        hold on;
        title(['Track of ', SeedName]);
        xlabel('X Position (m)');
        ylabel('Y Position (m)');
        scatter(metricSeedTrack(:,1),metricSeedTrack(:,2),10,metricSeedTrack(:,3));
        c = colorbar('southoutside');
        c.Label.String = 'Time (s)';
        axis equal;
        %plotComponentGraphs(metricSeedTrack);
    end
   
    %find raw velocities, found with differences between sucessive
    %timepoints
    velocitiesRawInstant = findVelocities(metricSeedTrack,1);
    angleVelocitiesRawInstant = findVelocities(metricSeedTrack,1);
    
    %find velocities smoothed over n datapoints
    velocities = findVelocities(metricSeedTrack,n);
    velocities_new = findVelocities_new(metricSeedTrack,n);
    %whos velocities
    %whos velocities_new
    anglevelocities = findVelocities(metricSeedTrack,m);
    %plot raw velocities
    if plotsOn
        plotVelocityComponentGraphs(velocitiesRawInstant)
        %plot smoothed velocities
        %plotVelocityComponentGraphs(velocities, n)
        %plotVelocityWithModel(velocities,n)
        plotVelocityWithModel(velocities_new,n)
    end
    %calculate and display average velocities
    averageVelocity = mean(velocitiesRawInstant(:,1:2));
    %calculate and display average acceletations from linear fits of the velocity graph
    %slopeVxT = polyfit(velocitiesRawInstant(:,3),velocitiesRawInstant(:,1),1)
    %slopeVyT = polyfit(velocitiesRawInstant(:,3),velocitiesRawInstant(:,2),1)
    %Find Accelerations
    accelerations = FindInstantAccelerations(metricSeedTrack, n);
    %plot Acceleration Graph
    %if plotsOn
        %plotAccelerationComponentGraphs(accelerations);
    %end
    %calculate and display average acceleration (second calculation method)
    %averageAcceleration = mean(accelerations(:,1:2))
    %averageAccelerationDueToAir = averageAcceleration - [0 -9.8]
    %plot velocity and acceleration vectors
    %if plotsOn
       % plotVelocityAccelerationVectors(averageVelocity, averageAcceleration);
       % plotVelocityAccelerationVectors(averageVelocity, averageAccelerationDueToAir);
    % end
    %Calculate Lift and Drag
    LiftDrag = FindLiftDrag(metricSeedTrack, n);
    %Plot Lift and Drag
    if plotsOn
        plotLiftDrag(LiftDrag, n);
    end
    %Calculate and Display average lift and drag
    %averageLiftDrag = mean(LiftDrag(:,1:2))
    %Calculate Lift and Drag Coefficients
    [LtoDratio, cLift, cDrag, time] = CoefficientsV2(metricSeedTrack, n);
    speed = sqrt(velocities_new(:,1).^2+velocities_new(:,2).^2);
    
    averageSpeed = mean(speed);
    if plotsOn
        %plot lift and drag coefficients
        plotLiftDragCoefficients(time, cLift,cDrag, n);
        plotLiftDragvSpeed(LiftDrag,speed,n)
        plotcLiftDragvSpeed([cLift,cDrag],speed,n)
    end
    %calulate and display average lift, average drag and average ratio
    averageBallisticParameterLift = mean(cLift);
    averageBallisticParameterDrag = mean(cDrag);
    %averageDragToLift = mean(LtoDratio)
    
    %Save local analysis variables
    if saveOn
        save(['Data Analysis of ', SeedName,'.mat']);
    end
    
    theta = rad2deg(atan(anglevelocities(1,2)/anglevelocities(1,1)));
    
    if theta < 0
        launchAngle = theta + 180;
        
    else
        launchAngle = theta;
    end
    

    
    figure;
    hold on;
    title(['Size of ', SeedName, ' vs. time, unsmoothed']);
    xlabel('Time (s)');
    ylabel('Size of particle (m^2)');
    scatter(metricSeedTrack(:,3), metricSeedTrack(:,4));
    hold off;
    
    figure;
    hold on;
    title(['Size of ', SeedName, ' vs. Time, smoothed by ', num2str(numSmooth), ' data points']);
    xlabel('Time (s)');
    ylabel('Size of particle (m^2)');
    sizeSmooth = smoothVectors(metricSeedTrack(:,4), numSmooth);
    timeSmooth = smoothVectors(metricSeedTrack(:,3), numSmooth);
    scatter(timeSmooth, sizeSmooth)
    hold off;
    
    figure;
    hold on;
    title(['Size of ', SeedName, ' vs. Speed, smoothed by ', num2str(numSmooth), ' data points']);

    scatter(speed, sizeSmooth(2:end)); %need to remove an element of sizeSmooth
    % to get it to be the same size as speed because speed is calculated
    % based on the difference in displacements, so the length of speed is
    % one less than the number of rows in metricSeedTrack (i.e., the length
    % of sizeSmooth). It's arbitrary whether we chop off from the front or
    % the back of sizeSmooth, but I also doubt it will matter much.
    
    disp("Statistics on linear model for size vs. speed")
    [size_fit,gof] = fit(speed, sizeSmooth(2:end), 'poly1') 
    plot(size_fit, 'b--')
    legend('Size','Linear regression');    
    xlabel('Speed (m/s)');
    ylabel('Size of particle (m^2)');
    hold off;
    
    averageVelocity
    averageSpeed
    averageBallisticParameterLift
    averageBallisticParameterDrag
    launchAngle
    
        %Using rho = 1.2041 kg/m^3 for air at 20 C and 1 atm
    if nargin > 4
        CoefDrag = 2*mass*averageBallisticParameterDrag/(1.2041*sizeTheory)
    end
end
