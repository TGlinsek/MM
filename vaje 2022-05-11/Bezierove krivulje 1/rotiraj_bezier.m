function [nov_b] = rotiraj_bezier(b, phi, risanje)
    % ROTIRAJ_BEZIER rotira Bezierovo krivuljo, podano s kontrolnimi
    % tockami b, za kot phi okrog prve kontrolne tocke. Izrise tudi
    % zacetno in rotirano krivuljo ter oba kontrolna poligona.

    if nargin < 3
        risanje = false;
    end

    nov_b = zasuci(b(1, :), b(2, :), phi);
    
    
    if risanje
        figure
        plotBezier(b)
        hold on
        plotBezier(nov_b)
    end
end