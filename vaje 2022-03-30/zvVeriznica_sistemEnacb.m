function [C, D, lambda] = zvVeriznica_sistemEnacb(T1, T2, l, tol)
    % Vhod:
    % T1 = [a; A]: levo obesišče, a je x koordinata, A pa y koordinata
    % T2 = [b; B]: desno obesišče

    % Izhod:
    % rešitve našega sistema treh enačb

    a = T1(1);
    A = T1(2);
    b = T2(1);
    B = T2(2);
    
    % sistem, ki ga rešujemo:
    % A = lambda + C*cosh((a - D)/C)
    % B = lambda + C*cosh((b - D)/C)
    % l = C*sinh((b - D)/C) - C*sinh((a - D)/C)
    % neznanke so C, D, lambda
    % konstante so a, A, b, B, l

    % definiramo nove neznanke:
    % u == (a - D)/C
    % v == (b - D)/C
    % z == (v - u)/2

    z_0 = 1;  % to se izkaže, da je dober začetni približek
    z = zvVeriznica_iteracijskaFun(T1, T2, l, z_0, tol);

    u = atanh((B - A)/l) - z;
    v = atanh((B - A)/l) + z;

    C = (b - a)/(v - u);
    D = (a*v - b*u)/(v - u);

    lambda = (A + B - C*(cosh((a - D)/C) + cosh((b - D)/C)))/2;
end

