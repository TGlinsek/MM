function [] = risi_brah(T1, T2)
    [~, theta_zvezdica, x, y] = brah(T1, T2);
    
    % narišemo od theta = 0 do theta = theta^*
    t = linspace(0, theta_zvezdica);
    figure
    plot(x(t), y(t))
end

