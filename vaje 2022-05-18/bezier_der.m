function tangenta = bezier_der(b, t)
    % tangentni vektor pri točki t
    
    [tangenta, nov_b_xs, nov_b_ys] = odvod_Bez(b, 1, t);
    tocka = [sum(nov_b_xs .* [1 - t, t]); sum(nov_b_ys .* [1 - t, t])];
    plotBezier(b)
    
    hold on
    plot(tocka(1), tocka(2), 'o')
    konica = tocka + tangenta;
    plot([tocka(1), konica(1)], [tocka(2), konica(2)])  % tangentni vektor
    axis equal
end

