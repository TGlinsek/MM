function [L, U] = LU_razcep_tridiagonalne_matrike(D, P, N)
    % diagonala = D, poddiagonala = P, naddiagonala = N
    n = length(D);
    assert(n - 1 == length(P), "Drugi argument mora biti za eno krajši od prvega!");
    assert(n - 1 == length(N), "Tretji argument mora biti za eno krajši od prvega!");

    L = diag(ones(1, n));  % ali pa kar L = eye(n)
    U = zeros(n);
    %{
    U(1, 1) = D(1)
    U(1, 2) = N(1)

    L(2, 1) = P(1) / U(1, 1)
    U(2, 2) = D(2) - P(1)
    U(2, 3) = N(2)

    L(3, 2) = P(2) / U(2, 2)
    U(3, 3) = D(3) - P(2)
    U(3, 4) = N(3)
    
    ...

    L(n, n - 1) = P(n - 1) / U(n - 1, n - 1)
    U(n, n) = D(n) - P(n - 1)
    %}

    U(1, 1) = D(1);

    for i = 2 : n
        U(i - 1, i) = N(i - 1);
        
        L(i, i - 1) = P(i - 1) / U(i - 1, i - 1);
        U(i, i) = D(i) - L(i, i - 1)*N(i - 1);
    end
    
end

