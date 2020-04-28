function plotVelocityWithModel(velocities, numSmoothed)
    figure;
    hold on;
    str = int2str(numSmoothed);
    titlestr = 'X and Y Velocity Component Graphs with Quadratic Drag model, smoothed by %s data points';
    titlestr = sprintf(titlestr,str);
    title(titlestr);

    t = velocities(:,3);
    l = length(velocities(:,2)); %num entries in y velocity
    %v_ter = mean(sqrt(velocities(floor(l/2):end,2).^2+velocities(floor(l/2):end,1).^2));
    fo = fitoptions('Method', 'NonlinearLeastSquares', 'Lower', [-5 -5], ...
        'Upper', [5 5], 'StartPoint', [1 0]);
    ft = fittype('a*tanh(-9.8*(x-b)/a)','options',fo);
    disp("Statistics on quadratic drag model for y-velocity")
    [y_model,gof] = fit(t,velocities(:,2),ft)
    
    %y_model = v_ter*tanh(-9.8*t/v_ter);

    plot(t,velocities(:,1))
    plot(t,velocities(:,2))
    plot(y_model, 'r--')
    hold off
    legend('x-velocity','y-velocity', 'y-velocity model');
    xlabel('Time (s)');
    ylabel('Velocity (m/s)');
end
