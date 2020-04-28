function plotLiftDrag(LiftDrag, n)
    figure;
    hold on;
    str = num2str(n);
    titlestr = 'Acceleration due to Lift and Drag vs. Time, smoothed by %s data points';
    titlestr = sprintf(titlestr,str);
    title(titlestr);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    plot(LiftDrag(:,3),[LiftDrag(:,1),LiftDrag(:,2)]);
    legend('Lift','Drag');
end