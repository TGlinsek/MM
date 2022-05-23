function [b] = parametrizacija(alfa, p, v, risanje)
    N = size(p, 2) - 1;
    u = [0];
    figure
    hold on
    plot(p(1, 1), p(2, 1), 'o')
    plot([p(1, 1), p(1, 1) + v(1, 1)], [p(2, 1), p(2, 1) + v(2, 1)])
    for i = 1 : N
        plot(p(1, i + 1), p(2, i + 1), 'o')
        plot([p(1, i + 1), p(1, i + 1) + v(1, i + 1)], [p(2, i + 1), p(2, i + 1) + v(2, i + 1)])
        u(i + 1) = u(i) + norm(p(:, i + 1) - p(:, i))^alfa;
    end
    b = C1CubicSpline(u, p, v, risanje);


    % alfa = 0: enakomerna parametrizacija
    % alfa = 1: tetivna parametrizacija
    % alfa = 0.5: centripetalna parametrizacija
end

