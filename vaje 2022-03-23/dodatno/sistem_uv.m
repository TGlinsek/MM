function Z = sistem_uv(W, zac, L, vsote_mi)
    % W začetni približek [u; v]
    % zac = [x_0, x_n_1; y_0, y_n_1]
    % L je vrstica dolžin palic
    % vsote_mi  % seznam dolžine n + 1 (isto kot ni, dejansko)


    [x_0, x_n_1] = zac(1, :);
    [y_0, y_n_1] = zac(2, :);

    n = length(L) - 1;

    assert(length(vsote_mi) == n + 1, "vsote_mi mora biti dolžine %d", n + 1);
    
    % ni = [0, cumsum(mi, 2)];  % seznam dolžine n + 1
    ni = vsote_mi;
    w = @(u, v) v - u * ni;  % seznam dolžine n + 1
    
    U = @(u, v) sum(L.*(1 + w(u, v).^2).^(-1/2).*w(u, v)) - (x_n_1 - x_0);
    V = @(u, v) sum(L.*(1 + w(u, v).^2).^(-1/2)) - (y_n_1 - y_0);
    U_in_V = @(u, v) [U(u, v); V(u, v)];

    u_0 = W(1);
    v_0 = W(2);
    priblizek = [u_0, v_0];
    

end

