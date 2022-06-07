function vrednost_uja = Brownovo_gibanje(L, l, x, y)
    % pravokotnik (0, L) x (0, l)
    % u(x, y) = verjetnost, da uide skozi vertikalno stranico
    % 1 - u(x, y) = verjetnost, da uide skozi horizontalno stranico
    % toleranca: ko je |S_(k + 1) - S_k| = a_k < tol, ustavimo konvergenco
    % namreč velja |S_k - L| <= |S_(k + 1) - S_k|, po Leibnizu

    k = 0;
    vsota = 0;
    tol = 0.000000000000000000000000000000000000000001;

    while true
        c = (2*k + 1)*pi/l;
        if x == L/2 && y == l/2
            a = 4/pi/(2*k + 1)*(-1)^k/cosh(c*L/2);
        else
            a = 4/pi/(2*k + 1)*((1 - cosh(c*L))/sinh(c*L)*sinh(c*x) + cosh(c*x))*sin(c*y);
        end
        vsota = vsota + a;
        k = k + 1;
        if a < tol && k >= 50
            break;
        end
    end
    vrednost_uja = vsota;
end

