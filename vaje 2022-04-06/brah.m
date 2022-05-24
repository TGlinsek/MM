function [k, theta_zvezdica, x, y, x_, y_, y_od_x, y_po_x] = brah(T1, T2)
    % T1 = [x1, y1]
    % T2 = [x2, y2]
    
    [k, theta_zvezdica] = transformacija(T1, T2);
    
    x = @(theta) 1/2 * k^2 * (theta - sin(theta)) + T1(1);
    y = @(theta) -1/2 * k^2 * (1 - cos(theta)) + T1(2);

    % odvod po theti
    x_ = @(theta) 1/2 * k^2 * (1 - cos(theta));
    y_ = @(theta) -1/2 * k^2 * sin(theta);


    % theta(x)
    theta = inverz(x);

    % y'(x):
    y_po_x = @(x) -cos(theta(x)/2)/sin(theta(x)/2);

    % y(x):
    y_od_x = @(x) -k^2/(1 + y_po_x(x)^2);
end

