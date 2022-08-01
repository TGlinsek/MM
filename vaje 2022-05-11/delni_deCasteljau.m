function [nov_b_xs, nov_b_ys] = delni_deCasteljau(b, l, t)
    % vrne točke pri l-tem koraku deCasteljauja
    % b je kontrolni poligon
    % t je točka, v kateri računamo. Lahko je tudi vektor točk. V tem
    % primeru pač 'ponovimo' ta algoritem za več različnih t-jev
    
    assert(length(t'*t) == 1  || length(t*t') == 1, "t bi moral biti vektor!")
    if length(t*t') == 1
        t = t';
    end
    
    assert(length(b*b') == 2, "stolpci b-ja morajo biti točke (tj. velikosti 2)!")

    n = length(b'*b) - 1;  % št kontrolnih točk
    s = length(t);  % št t-jev

    assert(0 <= l && l <= n, "Neustrezno število korakov!");

    xs = ones(s, 1)*b(1, :);
    ys = ones(s, 1)*b(2, :);
    
    for i = 1 : l
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
    
    nov_b_xs = xs(:, l + 1:end);  % s x (n - l + 1)
    nov_b_ys = ys(:, l + 1:end);  % s x (n - l + 1)

    % nov_b_xs - vsaka vrstica je za svojo točko t, vsak stolpec pa je
    % svoja točka v dobljenem kontrolnem poligonu. V nov_b_xs so le 
    % x-koordinate podobno velja za nov_b_ys
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
