function plotVelocityComponentGraphs(metricVelocities, numSmoothed)
    figure;
    hold on;
    
    if nargin == 1
        title('X and Y Velocity Component Graphs, unsmoothed');
        xlabel('Time (s)');
        ylabel('Velocity (m/s)');
        plot(metricVelocities(:,3),[metricVelocities(:,1),metricVelocities(:,2)]);
        legend('x-velocity','y-velocity'); 
    end
    if nargin == 2
        str = int2str(numSmoothed);
        titlestr = 'X and Y Velocity Component Graphs, smoothed by %s data points';
        titlestr = sprintf(titlestr,str);
        title(titlestr);
        xlabel('Time (s)');
        ylabel('Velocity (m/s)');
        plot(metricVelocities(:,3),[metricVelocities(:,1),metricVelocities(:,2)]);
        legend('x-velocity','y-velocity');
    end
    
    
end