function [y] = resi_dif_1(f, a, b, n, c, risanje)
    % f = f(t, y)
    % reši y' = f(t, y)
    % pogoj: y(0) = c
    % interval [a, b]

    if nargin < 6
        risanje = false;
    end

    t = linspace(a, b, n);

    [~, y] = ode45(f, t, c);  % vrne 100 vrednosti z intervala [a, b]

    if risanje
        figure
        plot(t, y)
    end
end

