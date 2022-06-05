function [l] = dolzina_loka(T1, T2)
    % vrne dolžino loka brahistohrone
    % T1(x1, y1), T2(x2, y2)

    [~, theta_zvezdica, ~, ~, x_, y_] = brah(T1, T2);
    
    locni_el = @(theta) sqrt(x_(theta).^2 + y_(theta).^2);

    l = integral(locni_el, 0, theta_zvezdica);
end

