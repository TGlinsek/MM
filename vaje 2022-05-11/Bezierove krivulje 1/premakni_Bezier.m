function [nov_b] = premakni_Bezier(b, vs, risanje)
    % PREMAKNI_BEZIER translira Bezierovo krivuljo, podano s kontrolnimi
    % tockami b, za vektorje vs. Izrise tudi zacetno in translirano 
    % krivuljo ter oba kontrolna poligona.

    % vs je seznam vektorjev. Vsak stolpec pripada svoji kontrolni točki

    assert(all(size(vs) == size(b)), "Napačne dimenzije parametra!")

    if nargin < 3
        risanje = false;
    end

    nov_b = b + vs;
    
    if risanje
        figure
        plotBezier(b)
        hold on
        plotBezier(nov_b)
        hold off
    end
end

