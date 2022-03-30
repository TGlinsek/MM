function [T_min, w] = zvVeriznica(T1, T2, l, tol)
    % Vhod:
    % T1: levo obesišče, oblike [a; A]
    % T2: desno obesišče, oblike [b; B]
    % l: dolžina verižnice
    % tol: toleranca pri iteraciji

    % Izhod:
    % T_min: najnižja točka verižnice
    % w: funkcija tipa 'function_handle', ki opisuje višino verižnice v
    % točki x
    
    [C, D, lambda] = zvVeriznica_sistemEnacb(T1, T2, l, tol);

    w = @(x) lambda + C*cosh((x - D)/C);
    T_min = [D; w(D)];  % dobimo z odvajanjem funkcije w
    
    a = T1(1);
    A = T1(2);
    b = T2(1);
    B = T2(2);

    x = linspace(a, b);
    plot(x, w(x), 'color', [0 0 1])
    hold on
    plot(a, A, 'o', 'color', 'red')
    plot(b, B, 'o', 'color', 'red')
    plot(T_min(1), T_min(2), 'o', 'color', 'green')
end

