function U = gauss_seidl(U, tol, sprotno_risanje)
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

        % pomožna spremenljivka za pridobivanje razlike:
        vmesna_razlika = 0;

        for i = 2 : n + 1
            for j = 2 : n + 1
                prej = U(i, j);  % si shranimo vrednost, da lahko poračunamo razliko
                U(i, j) = (U(i - 1, j) + U(i + 1, j) + U(i, j - 1) + U(i, j + 1))/4;  % povprečje
                vmesna_razlika = max(abs(prej - U(i, j)), vmesna_razlika);
            end
        end
        razlika = vmesna_razlika;


        surf(X, Y, U);
        pause(1)
        % shading interp

        st_iteracij = st_iteracij + 1;
    end
    fprintf("Opravljenih je bilo %d iteracij.", st_iteracij)
end

