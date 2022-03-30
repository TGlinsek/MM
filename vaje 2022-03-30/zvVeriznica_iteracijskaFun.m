function [z] = zvVeriznica_iteracijskaFun(T1, T2, l, z_0, tol)
    % Vhod:
    % T1 = [a; A]: levo obesišče, a je x koordinata, A pa y koordinata
    % T2 = [b; B]: desno obesišče
    % L: dolžina verižnice
    % z_0: začetni približek
    % tol: toleranca pri zaustavitvi iteracije

    % Izhod:
    % z: numerična rešitev enačbe z = asinh(ro*z),
    % kjer ro konstanta, kot je definirana spodaj

    
    % lahko bi dobili a, b, A, B:
    % a = T1(1)
    % A = T1(2)
    % b = T2(1)
    % B = T2(2)

    % ampak se izkaže, da potrebujemo le razlike:
    razlika = T2 - T1;
    b_minus_a = razlika(1);
    B_minus_A = razlika(2);

    % namesto fzero bomo šli kar z navadno iteracijo
       
    % v članku se za izraz navadna iteracija uporablja kar Jacobijeva
    % iteracija
    ro = (l/b_minus_a) * sqrt(1 - (B_minus_A/l)^2);
    g = @(z) asinh(ro*z);
    z = navadna_iteracija(g, z_0, tol);
end

