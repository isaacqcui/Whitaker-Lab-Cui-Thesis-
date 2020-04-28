function plotcLiftDrag(LiftDrag,speed,n)
    figure;
    hold on;
    lift = LiftDrag(:,1);
    drag = LiftDrag(:,2);
    scatter(speed,lift)
    %lift_fit = polyval(p1,speed); 
    disp("Statistics on linear models for ballistic parameters vs. speed")
    [lift_model,gof] = fit(speed, lift,'poly1')

    scatter(speed,drag)
    %p2 = polyfit(speed, drag, 1)
    %drag_fit = polyval(p2,speed);
    %plot(speed, lift_fit, 'b--')
    %plot(speed, drag_fit, 'r--')
    [drag_model,gof] = fit(speed,drag,'poly1')
    plot(lift_model, 'b--')
    plot(drag_model, 'r--')
    hold off;
    str = num2str(n);
    titlestr = 'Ballistic parameter vs. Speed, smoothed by %s data points';
    titlestr = sprintf(titlestr,str);
    title(titlestr);
    xlabel('Speed (m/s)');
    ylabel('Ballistic parameter (m^{-1})');
    legend('Lift','Drag', "Lift linear regression", "Drag linear regression");    
end