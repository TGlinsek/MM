function [l] = dolzina_loka(T1, T2)
    % vrne dolžino loka brahistohrone
    % T1(x1, y1), T2(x2, y2)

    [k, theta_zvezdica, ~, ~] = brah(T1, T2);

    x_ = @(theta) k^2/2*(1 - cos(theta));
    y_ = @(theta) -k^2/2 * sin(theta);
    
    locni_el = @(theta) sqrt(x_(theta).^2 + y_(theta).^2);

    l = integral(locni_el, 0, theta_zvezdica);
end

