function [k, theta_zvezdica, x, y, x_, y_, y_od_x, y_po_x, y_po_x_od_thete, y_po_theti_od_x] = brah(T1, T2)
    % T1 = [x1, y1]
    % T2 = [x2, y2]

    [b, B] = transformacija(T1, T2);
    [k, theta_zvezdica] = isci_theta_k(b, B);
    
    x = @(theta) 1/2 * k^2 * (theta - sin(theta)) + T1(1);
    y = @(theta) -1/2 * k^2 * (1 - cos(theta)) + T1(2);

    % odvod po theti
    x_ = @(theta) 1/2 * k^2 * (1 - cos(theta));
    y_ = @(theta) -1/2 * k^2 * sin(theta);


    % theta(x)
    theta = inverz(x);

    % y'(x):
    y_po_x = @(x) -cos(theta(x)./2)./sin(theta(x)./2);

    % y(x):
    y_od_x = @(x) -k^2./(1 + y_po_x(x).^2) + T1(2);

    % y'(theta) = odvod po x, od thete
    y_po_x_od_thete = @(theta) -cos(theta/2)./sin(theta./2);
    % y_po_x_od_thete = @(theta) sin(theta)./(cos(theta) - 1);

    % y^.(x) = odvod po theti, od x
    y_po_theti_od_x = @(x) y_(theta(x));
end

