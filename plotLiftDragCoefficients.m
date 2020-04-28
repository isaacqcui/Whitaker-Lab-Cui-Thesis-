function plotLiftDragCoefficients(time, liftCoefficients, dragCoefficients,n)
    figure;
    hold on;
    str = num2str(n);
    titlestr = 'Ballistic parameter vs. Time, smoothed by %s data points';
    titlestr = sprintf(titlestr,str);
    title(titlestr);
    xlabel('Time (s)');
    ylabel('Ballistic parameter (m^{-1})');
    plot(time,[liftCoefficients,dragCoefficients]);
    legend('Lift','Drag');
end