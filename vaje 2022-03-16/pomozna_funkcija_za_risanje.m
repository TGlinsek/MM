function [] = pomozna_funkcija_za_risanje(f, x1, x2, xn, y1, y2, yn)
    % risanje
    x = linspace(x1, x2, xn);
    y = linspace(y1, y2, yn);

    [X, Y] = meshgrid(x, y);
    % [X, Y] = ndgrid(x, y);  % alternativno

    surf(X, Y(end:-1:1, :), f(X, Y(end:-1:1, :)))
    % če uporabimo ndgrid: surf(X', Y(:, end:-1:1)', f(X', Y(:, end:-1:1)'));
    
    shading interp
end

