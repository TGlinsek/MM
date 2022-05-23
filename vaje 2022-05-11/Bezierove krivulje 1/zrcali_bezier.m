function [nov_b] = zrcali_bezier(b, risanje)
    % ZRCALI_BEZIER prezrcali Bezierovo krivuljo, podano s kontrolnimi
    % tockami b, preko premice p, dolocene z zacetno in koncno kontrolno tocko.
    % Izrise tudi zacetno in prezrcaljeno krivuljo ter oba kontrolna poligona.

    if nargin < 2
        risanje = false;
    end

    prva = b(:, 1);  % prva kontrolna točka
    zadnja = b(:, end);  % zadnja kontrolna točka
    
    nov_b = zrcali(prva, zadnja, b);
    
    if risanje
        figure
        plotBezier(b)
        hold on
        plotBezier(nov_b)
    end
end

function [zrcaljene_tocke] = zrcali(prva, zadnja, tocke)
    vektor_do_prve = prva * ones(1, size(tocke, 2)) - tocke;
    od_prve_do_zadnje = (zadnja - prva) * ones(1, size(tocke, 2));  % vektor od prve do zadnje kontrolne točke
    % vektor_do_zadnje = zadnja * ones(1, size(tocke, 2)) - tocke;
    % velja vektor_do_zadnje = vektor_do_prve + od_prve_do_zadnje

    projekcija = sk_prod(vektor_do_prve, od_prve_do_zadnje) ./ sk_prod(od_prve_do_zadnje, od_prve_do_zadnje) .* od_prve_do_zadnje;

    zrcaljene_tocke = tocke + 2*(vektor_do_prve - projekcija);
end

function rez = sk_prod(A, B)
    % skalarni produkt
    % oba parametra sta matriki vektorjev
    % vektorji so v stolpcih
    assert(size(A, 2) == size(B, 2), "Seznama morata imeti enako število vektorjev!")
    rez = diag(A' * B)';
end