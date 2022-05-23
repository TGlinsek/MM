function [odvod, nov_b_xs, nov_b_ys] = odvod(b, k, t)
    % k-ti odvod Bézierjeve krivulje, podane s kontrolnim poligonom b,
    % v točkah t

    assert(size(b, 1) == 2, "b mora imeti natanko dve vrstici!")
    assert(size(t, 2) == 1, "t mora biti vektor!")
    % s = length(t);

    n = size(b, 2) - 1;

    [nov_b_xs, nov_b_ys] = razsirjen_deCasteljau(b, n - k, t);
    
    dif = diferenca(nov_b_xs, nov_b_ys, k, 0);  % vektor z 2 * s vrsticami
    
    padajoca_potenca = prod(n:-1:n - k + 1);
    odvod = padajoca_potenca * dif;  % 2 x s
end

