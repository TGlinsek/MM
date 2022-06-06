function [minimalni_vektor, minimum] = globalni_min(f, intervali, limite)
    % f sprejema vektorje velikosti n in vrača skalar
    % globalni_min vrne vektor minimalni_vektor, pri katerem je f minimalen na intervalih
    % X_0 je vektor velikosti n. Je začetni približek. X_0 živi v domeni F
    assert(size(intervali, 2) == 2, "Širina drugega parametra mora biti 2.")
    n = size(intervali, 1);
    
    tol = 1e-10;  % včasih je treba toleranco znižat
    options = optimoptions('fmincon', 'StepTolerance', tol);

    % kako na drobno razbijemo intervale?
    if nargin < 3
        limite = 3 * ones(1, n);  % po vsaki dimenziji pogledamo na 3 točke
    end
    assert(size(limite, 1) == 1 && size(limite, 2) == n, "Limite niso pravih dimenzij")

    % primer: če limita 3, potem bomo vzeli obe krajišči in še razpolovišče
    % na teh treh točkah (na teh začetnih približkih) potem pogledamo 
    % lokalni minimum
    
    X_0 = intervali(:, 1);
    minimum = inf;
    minimalni_vektor = [];
    prisli_smo_do_konca = false;
    while ~prisli_smo_do_konca
        v = fmincon(f, X_0, [], [], [], [], intervali(:, 1)', intervali(:, 2)', [], options);
        
        nov_morebitni_minimum = f(v);
        if nov_morebitni_minimum < minimum
            minimalni_vektor = v;
            minimum = nov_morebitni_minimum;
        end

        % posodobimo začetni približek (X_0):
        X_0(1) = X_0(1) + (intervali(1, 2) - intervali(1, 1))/(limite(1) - 1);
        for indeks = 1 : n
            clen = X_0(indeks);
            if clen >= intervali(indeks, 2) + (intervali(indeks, 2) - intervali(indeks, 1))/(limite(indeks) - 1)  % dovolj bi blo ==, ampak se bojim numeričnih napak
                X_0(indeks) = intervali(indeks, 1);
                if indeks == n  % prišli smo do konca
                    prisli_smo_do_konca = true;
                    break
                end
                X_0(indeks + 1) = X_0(indeks + 1) + (intervali(indeks + 1, 2) - intervali(indeks + 1, 1))/(limite(indeks + 1) - 1);
            end
        end
    end

    %{
    % Lokalni minimum poiščemo kot:
    v = fmincon(f, X_0, [], [], [], [], intervali(:, 1)', intervali(:, 2)', [], options);

    % Ker nas 3., 4., 5. in 6. parameter ne zanimajo, jih pustimo prazne.
    % Alternativno, a bolj neumno:

    a = 3;  % izberemo poljuben a
    b = 5;  % izberemo poljuben b
    v = fmincon(f, X_0, zeros(a, n), zeros(a, 1), zeros(b, n), zeros(b, 1), intervali(:, 1)', intervali(:, 2)', [], options);
    % ampak ker sta lahko a in b poljubna, ju lahko nastavimo kar na 0 in
    % dobimo isto kot zgoraj
    %}
end

