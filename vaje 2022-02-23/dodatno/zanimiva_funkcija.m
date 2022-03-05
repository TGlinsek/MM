% nima veze s predmetom
function [F] = zanimiva_funkcija(A)
    % funkcija, ki najde vse NaN-e v A-ju in jih zamenja z A(1)
    N = isnan(A);
    [a, b] = size(A);
    len = a * b;
    % B = ones(size(A));  % matrika enic iste dimenzije kot A
    C = reshape(1 : len, a, b);
    D = N .* reshape(0 : len - 1, a, b);
    E = C - D;
    F = A(E);
end

