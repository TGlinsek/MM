function plotBezier(b)
    % PLOTBEZIER izrise Bezierovo krivuljo in kontrolni poligon. Za izracun
    % tocke na krivulji uporabimo deCasteljauov algoritem.
    % Stolpci matrike b so kontrolne tocke Bezierove krivulje.
    
    x_koords = b(1, :);
    y_koords = b(2, :);
    plot(x_koords, y_koords)
    hold on

    t = linspace(0, 1);

    tocke = deCasteljau(b, t');

    x_koords = tocke(1, :);
    y_koords = tocke(2, :);
    plot(x_koords, y_koords)
    hold off
    % daspect([1 1 1])
    axis equal  % isto kot daspect, ampak bolje
end

