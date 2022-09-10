function [y] = resi_dif_1(f, a, b, n, c, ode_metoda, risanje)
    % f = f(t, y)
    % reši y' = f(t, y)
    % pogoj: y(0) = c
    % interval [a, b]

    if nargin < 7
        risanje = false;
    end

    if nargin < 6
        ode_metoda = @ode45;
    end

    t = linspace(a, b, n);

    [~, y] = ode_metoda(f, t, c);  % vrne 100 vrednosti z intervala [a, b]

    if risanje
        figure
        plot(t, y)
    end
end

