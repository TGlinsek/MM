function U = jacobi(U, tol)
    % U je matrika (n + 2) × (n + 2)
    % U ima v notranjosti ničle, na robu pa vrednosti
    % število podintervalov: n + 1
    % število notranjih točk: n

    % iteracija se ustavi, ko največja razlika med istoležnima vrednostma
    % manjša od tolerance
    
    n = length(U) - 2;
    razlika = inf;

    st_iteracij = 0;

    x = linspace(0, 1, n + 2);
    y = linspace(0, 1, n + 2);

    [X, Y] = ndgrid(x, y);
    

    while razlika >= tol
        % zamaknemo matrike
        % prazna mesta zapolnimo z nani
        navzgor = [nan(n + 4, 1) [U; nan(2, n + 2)] nan(n + 4, 1)];  % spodnji sosed
        navzdol = [nan(n + 4, 1) [nan(2, n + 2); U] nan(n + 4, 1)];  % zgornji sosed
        v_levo = [nan(1, n + 4); U nan(n + 2, 2); nan(1, n + 4)];  % desni sosed
        v_desno = [nan(1, n + 4); nan(n + 2, 2) U; nan(1, n + 4)];  % lev sosed
        % npr., če matriko zamaknemo gor, bomo na določenem mestu dobili
        % spodnjega soseda
        
        % povprečje
        razsirjena_matrika = (navzgor + navzdol + v_levo + v_desno)/4;
        
        U2 = razsirjena_matrika(2 : end - 1, 2 : end - 1);  % se znebimo zunanjega okvirja, ki nas ne zanima
        okvir = isnan(U2);  % robne vrednosti (so postale nan, saj nimajo štirih sosedov)
        U2(okvir) = U(okvir);  % prekopiramo rob iz prejšnje matrike
    
        razlika = max(max(abs(U - U2)));  % največja razlika v tem koraku
        U = U2;

        
        surf(X, Y, U);
        pause(1)
        % shading interp

        st_iteracij = st_iteracij + 1;
    end
    fprintf("Opravljenih je bilo %d iteracij.", st_iteracij)
end

