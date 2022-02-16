function [A] = blocna_2(n)
    % drug pristop, ki uporablja kroneckerjev produkt
    
    T = diag(-4*ones(n, 1));
    T = T + diag(ones(n - 1, 1), 1);
    T = T + diag(ones(n - 1, 1), -1);

    A = kron(eye(n), T);
    A = A + kron(diag(ones(n - 1, 1), 1), eye(n));
    A = A + kron(diag(ones(n - 1, 1), -1), eye(n));
end

