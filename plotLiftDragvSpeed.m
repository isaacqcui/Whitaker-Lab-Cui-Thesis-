function plotLiftDrag(LiftDrag,speed,n)
    figure;
    hold on;
    str = num2str(n);
    titlestr = 'Acceleration due to Lift and Drag vs. Speed, smoothed by %s data points';
    titlestr = sprintf(titlestr,str);
    title(titlestr);
    lift = LiftDrag(:,1);
    drag = LiftDrag(:,2);
    scatter(speed,lift)
    scatter(speed,drag)

    disp("Statistics on quadratic models for acceleration due to lift and drag vs. speed")
    [lift_model,gof] = fit(speed, lift, 'poly2')
    [drag_model,gof] = fit(speed, drag, 'poly2')
    plot(lift_model, 'b--')
    plot(drag_model, 'r--')
    xlabel('Speed (m/s)');
    ylabel('Acceleration (m/s^2)');
    legend('Lift','Drag', "Lift quadratic regression", "Drag quadratic regression");
end