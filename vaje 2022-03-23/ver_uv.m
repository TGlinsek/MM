function vozlisca = ver_uv(W0, zac, L, M)
    % W0 začetni približek [u0, v0]
    % zac = [x_0, x_n_1; y_0, y_n_1]
    % L je vrstica dolžin palic
    % M  % seznam dolžine n + 1

    x_0 = zac(1, 1);
    x_n_1 = zac(1, 2);
    y_0 = zac(2, 1);
    y_n_1 = zac(2, 2);

    n = length(L) - 1;

    assert(length(M) == n + 1, "M mora biti dolžine %d", n + 1);
    
    pomozna_spr = (1/2)*([M, 0] + [0, M]);  % seznam dolžine n + 2
    mi = pomozna_spr(2:end - 1);  % seznam dolžine n

    ni = [0, cumsum(mi, 2)];  % seznam dolžine n + 1
    w = @(u, v) v - u * ni;  % seznam dolžine n + 1
    
    U = @(u, v) sum(L.*(1 + w(u, v).^2).^(-1/2)) - (x_n_1 - x_0);
    V = @(u, v) sum(L.*(1 + w(u, v).^2).^(-1/2).*w(u, v)) - (y_n_1 - y_0);
    

    U_in_V = @(vekt) [U(vekt(1), vekt(2)); V(vekt(1), vekt(2))];
    
    u_0 = W0(1);
    v_0 = W0(2);
    
    priblizek = [u_0, v_0];
    
    % rez = Newtonova_metoda(x_0, y_0, x_n_1, y_n_1, L, mi, u_0, v_0);
    options = optimset('Display','off');
    rez = fsolve(U_in_V, priblizek, options);
    u = rez(1);
    v = rez(2);
    U_in_V([u, v]);

    ksi = L./sqrt(1 + w(u, v).^2);  % seznam dolžine n + 1
    ni = ksi.*w(u, v);
    
    x = x_0 + [0, cumsum(ksi, 2)];
    y = y_0 + [0, cumsum(ni, 2)];
    vozlisca = [x; y];
    
end

