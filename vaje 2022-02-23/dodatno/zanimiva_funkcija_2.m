% nima veze s predmetom
function [F] = zanimiva_funkcija_2(A, c)
    % funkcija, ki najde vse NaN-e v A-ju in jih zamenja s c
    % malo bolj 'funkcionalen' pristop (brez ifov, forov in spreminjanj vrednosti elementov matrik)

    G = [A(:)' c];
    N = isnan(A);
    [a, b] = size(A);
    len = a * b;
    % B = ones(size(A));  % matrika enic iste dimenzije kot A
    C = reshape(1 : len, a, b);
    D = N .* reshape(-len : -1, a, b);  % hočemo, da je razlike pri NaNih (len + 1)
    E = C - D;
    F = G(E);

    % morda se da to zapisati v eni sami vrstici
    % potem lahko morda iz tega sestavimo enovrstični ternary operator
end

