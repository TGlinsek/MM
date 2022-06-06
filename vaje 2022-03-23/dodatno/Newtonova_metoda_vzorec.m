function [trenutni_priblizek] = Newtonova_metoda_vzorec(U, V, u_0, v_0)
    % ne dela: odvod ni numerično stabilna stvar
    
    % U = U(u, v), V = V(u, v)
    
    % parcialne funkcije
    Uu = @(v) @(u) U(u, v);
    Uv = @(u) @(v) U(u, v);

    Vu = @(v) @(u) V(u, v);
    Vv = @(u) @(v) V(u, v);


    % parcialni odvodi
    U_u = @(u, v) odvod(Uu(v), u);  % odvod(f, x_0)
    U_v = @(u, v) odvod(Uv(u), v);
    
    V_u = @(u, v) odvod(Vu(v), u);
    V_v = @(u, v) odvod(Vv(u), v);


    Jacobian = @(u, v) [U_u(u, v) U_v(u, v); V_u(u, v) V_v(u, v)];

    vektor = @(u, v) [U(u, v); V(u, v)];
    
    trenutni_priblizek = [u_0; v_0];

    razlika = [inf; inf];

    while all(abs(razlika) < [0.1; 0.1])
        razlika = Jacobian(trenutni_priblizek)\vektor(trenutni_priblizek);
        nov_priblizek = trenutni_priblizek - razlika;
        trenutni_priblizek = nov_priblizek;
    end
    
end

