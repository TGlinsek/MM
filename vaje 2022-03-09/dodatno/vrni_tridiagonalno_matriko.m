function T = vrni_tridiagonalno_matriko(D, P, N)
    T = diag(D) + diag(P, -1) + diag(N, 1);
end

