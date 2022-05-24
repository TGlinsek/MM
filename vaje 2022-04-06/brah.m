function [k, theta_zvezdica, x, y] = brah(T1, T2)
    % T1 = [x1, y1]
    % T2 = [x2, y2]
    
    [k, theta_zvezdica] = transformacija(T1, T2);
    
    x = @(theta) 1/2 * k^2 * (theta - sin(theta)) + T1(1);
    y = @(theta) -1/2 * k^2 * (1 - cos(theta)) + T1(2);
end

