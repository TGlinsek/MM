function [] = risi_brah(T1, T2)
    % T1 = [x1, y1]
    % T2 = [x2, y2]
    
    [k, theta_zvezdica] = transformacija(T1, T2);

    x = @(theta) 1/2 * k^2 * (theta - sin(theta));
    y = @(theta) -1/2 * k^2 * (1 - cos(theta));
    
    % narišemo od theta = 0 do theta = theta^*
    t = linspace(0, theta_zvezdica);
    plot(x(t), y(t))
end

