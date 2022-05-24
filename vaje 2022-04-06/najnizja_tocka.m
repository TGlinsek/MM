function [x0, theta_0, y0] = najnizja_tocka(T1, T2)
    % vrne točko x, kjer brahistohrona najnižja
    % T1(x1, y1), T2(x2, y2)
    
    [~, theta_zvezdica, x, y] = brah(T1, T2);
    theta_0 = min(theta_zvezdica, pi);
    
    t = linspace(0, theta_zvezdica);
    figure
    plot(x(t), y(t))
    hold on
    plot(x(theta_0), y(theta_0), 'o')
    
    x0 = x(theta_0);
    y0 = y(theta_0);
end

