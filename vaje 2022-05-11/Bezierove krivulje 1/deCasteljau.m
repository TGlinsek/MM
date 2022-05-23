function [tocke, xs, ys] = deCasteljau(b, t)
    % DE_CASTELJAU izracuna tocko na Bezierovi krivulji pri parametru t
    % s pomocjo de Casteljauovega algoritma.
    % Stolpci matrike b so kontrolne tocke Bezierove krivulje.

    % t je lahko tudi vektor: v tem primeru izrišemo več točk naenkrat

    % algoritem temelji na trikotni shemi

    % za optimizacijo spomina bomo prejšnje stolpce v trikotni shemi
    % kar čez prepisali

    assert(length(t'*t) == 1, "t bi moral biti vektor!")
    assert(length(b*b') == 2, "stolpci b-ja morajo biti točke (tj. velikosti 2)!")

    n = length(b'*b) - 1;  % št kontrolnih točk
    s = length(t);  % št t-jev

    xs = ones(s, 1)*b(1, :);  % dimenzije s x (n + 1). Dimenzija se ne spreminja
    ys = ones(s, 1)*b(2, :);
    
    for i = 1 : n
        X1 = cudno_mnozenje(xs(:, i:end - 1), ones(s, 1) - t);
        X2 = cudno_mnozenje(xs(:, i + 1:end), t);
        Y1 = cudno_mnozenje(ys(:, i:end - 1), ones(s, 1) - t);
        Y2 = cudno_mnozenje(ys(:, i + 1:end), t);
        xs = [xs(:, 1:i), X1 + X2];
        ys = [ys(:, 1:i), Y1 + Y2];
    end
    % xs in ys se polnita na koncu. Tj. prvi stolpec se sploh ne bo
    % spremenil, drugi stolpec se bo le po prvem koraku, ...
    % zadnji stolpec pa se bo spremenil na vsakem koraku

    tocke_x = xs(:, end);  % vektor dolžine s
    tocke_y = ys(:, end);

    tocke = [tocke_x'; tocke_y'];  % matrika 2 x s
end

function B = cudno_mnozenje(A, t)
    % naj t vektor dolžine s
    % naj A matrika višine s in dolžine n
    % hočemo dobiti matriko B, ki je istih dimenzij kot A, ampak vsaka
    % vrstica pomnožena z respektivnim elementom vektorja t 
    % (torej, množenje po vrsticah nekako)

    assert(length(t*t') == length(A*A'), "Višini A-ja in t-ja morata biti enaki.")

    B = diag(t)*A;
end