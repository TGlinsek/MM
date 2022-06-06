function [y, y_] = resi_dif_2(f, a, b, n, c, d, risanje)
    % f = f(t, y, y')
    % reši y'' = f(t, y, y')
    % pogoj: y(0) = c, y'(0) = d
    % interval [a, b]
    
    if nargin < 7
        risanje = false;
    end

    t = linspace(a, b, n);

    F = @(t, Y) [Y(2) f(t, Y(1), Y(2))]';
    [~, Y] = ode45(F, t, [c d]);  % vrne 100 vrednosti z intervala [a, b]
    y = Y(:, 1);
    y_ = Y(:, 2);

    if risanje
        figure
        plot(t, y)
        hold on
        plot(t, y_)
        legend('višina', 'hitrost')
    end

    % v splošnem: n-ti red:
    % Y(n) : (n - 1)-ti odvod
    % F = @(t, Y) [Y(2) Y(3) ... Y(n) f(t, Y(1), Y(2), ..., Y(n))]';
    % [~, Y] = ode45(F, t, [c_1 c_2 ... c_n])
    % Y(:, 1) je y
    % Y(:, 2) je y'
    % ...
    % Y(:, n) je y^(n - 1)
    % y^(n) je pa pač f(t, y, y', ..., y^(n - 1))
end

