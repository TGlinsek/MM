function [priblizek] = Newtonova_metoda(x_0, y_0, x_n_1, y_n_1, L, mi, u_0, v_0)
    % (x_0, y_0): levo obesišče
    % (x_n_1, y_n_1): desno obesišče
    % L: seznam dolžine n + 1
    % mi: seznam dolžine n
    % u_0, v_0: začetni približek
    
    n = length(L) - 1;

    assert(length(mi) == n, "mi mora biti dolžine %d", n);
    
    ni = [0, cumsum(mi, 2)];  % seznam dolžine n + 1
    w = @(u, v) v - u * ni;  % seznam dolžine n + 1
    
    U = @(u, v) sum(L.*(1 + w(u, v).^2).^(-1/2).*w(u, v)) - (x_n_1 - x_0);
    V = @(u, v) sum(L.*(1 + w(u, v).^2).^(-1/2)) - (y_n_1 - y_0);
    U_in_V = @(u, v) [U(u, v); V(u, v)];

    priblizek = [u_0; v_0];

    razlika = [inf; inf];

    while all(abs(razlika) >= [0.1; 0.1])
        razlika = Jac(priblizek(1), priblizek(2), n, L, w, ni)\U_in_V(priblizek(1), priblizek(2));
        nov_priblizek = priblizek - razlika;
        priblizek = nov_priblizek;
    end
    
end

function J = Jac(u, v, n, L, w, ni)
    % vrne @(u, v) [U_u(u, v) U_v(u, v); V_u(u, v) V_v(u, v)]
    J = zeros(2);
    for i = 1 : n + 1
        J = J + delni_Jac(u, v, i, L, w, ni);
    end
end

function J_ = delni_Jac(u, v, i, L, w, ni)
    % vrne @(u, v) [ksi_i_u(u, v) ksi_i_v(u, v); eta_i_u(u, v) eta_i_v(u, v)]
    w_ji = w(u, v);
    J_ = L(i)*(1 + w_ji(i)^2)^(-3/2) * [w_ji(i)*ni(i), -w_ji(i); -ni(i), 1];
end

