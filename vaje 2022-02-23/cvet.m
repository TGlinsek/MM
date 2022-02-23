function [] = cvet(a, b, n)
    elipsa_x = @(x) a.*cos(x);
    elipsa_y = @(y) b.*sin(y);
    t = linspace(0, 2*pi);
    A = [elipsa_x(t); elipsa_y(t)];
    hold on
    for i = 1 : n
        plot(elipsa_x(t), elipsa_y(t));
        A = ([cos(2*pi/n) sin(2*pi/n); -sin(2*pi/n) cos(2*pi/n)]*[A(1, 1:end); A(2, 1:end)]);
        plot(A(1, 1:end), A(2, 1:end));
    end
    hold off
end

