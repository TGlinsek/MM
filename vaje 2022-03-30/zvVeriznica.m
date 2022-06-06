function [T_min, w, w_] = zvVeriznica(T1, T2, l, tol, risanje)
    % Vhod:
    % T1: levo obesišče, oblike [a; A]
    % T2: desno obesišče, oblike [b; B]
    % l: dolžina verižnice
    % tol: toleranca pri iteraciji

    % Izhod:
    % T_min: najnižja točka verižnice
    % w: funkcija tipa 'function_handle', ki opisuje višino verižnice v
    % točki x

    if nargin < 5
        risanje = false;
    end
    if nargin < 4
        tol = toleranca();
    end
    a = T1(1);
    A = T1(2);
    b = T2(1);
    B = T2(2);

    if b <= a
        fprintf("T2 mora biti desno od T1. \n")
        return
    end

    if l^2 < (b - a)^2 + (B - A)^2
        fprintf("Verižnica je prekratka za podani obesišči. \n");
        return
    end

    [C, D, lambda] = zvVeriznica_sistemEnacb(T1, T2, l, tol);

    w = @(x) lambda + C*cosh((x - D)/C);
    % odvod bi bil:
    % w' = @(x) sinh((x - D)/C)
    w_ = @(x) sinh((x - D)/C);
    T_min = [D; w(D)];  % dobimo z odvajanjem funkcije w

    if risanje
        x = linspace(a, b);
        plot(x, w(x), 'color', [0 0 1])
        hold on
        plot(a, A, 'o', 'color', 'red')
        plot(b, B, 'o', 'color', 'red')
        plot(T_min(1), T_min(2), 'o', 'color', 'green')
    end
end

