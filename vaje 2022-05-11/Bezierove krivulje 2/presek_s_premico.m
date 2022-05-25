function Tp = presek_s_premico(b, l, tol, risanje)
    % Poisce presek ravninske Bezierove krivulje 
    % s premico l podano s tocko P in smernim vektorjem s.
    % Presek se izracuna preko kontrolnega poligona krivulje b, subdivizije sub_demo in metode seka_mnogokotnik
    
    % Tp je tabela tock presecisc (ce ni presecisca, vrne prazno matriko)
    % b je tabela 2x(n+1) kontrolnih tock po stolpcih
    % l = [P,s]
    % tol je natancnost, do katere isce presecisce.

    % IDEJA:
    % vsakič razpolovimo bezierovo krivuljo na sredini
    % pogledamo obe subdiviziji in ponovimo postopek v primeru, da premica
    % seka kontrolni poligon
    % če ga ne seka, potem ne rabimo več gledati
    
    if nargin < 4
        risanje = false;
    end

    dolzina = size(b, 2);

    premer = norm(b(:, end) - b(:, 1));  % razdalja med prvo in zadnjo točko
    povprecje = sum(b')'/dolzina;
    if seka_mnogokotnik(l, b) && premer >= tol
        [leva, desna] = sub_demo(b, 0.5, false);
        Tp = [presek_s_premico(leva, l, tol, false), presek_s_premico(desna, l, tol, false)];
        toleranca_za_unikatnost = tol * 5;  % to naj bo malo večje kot tol
        Tp = uniquetol(Tp', toleranca_za_unikatnost, 'ByRows', true)';
    elseif premer < tol
        Tp = povprecje;
    else
        Tp = [];
    end

    if risanje
        figure
        plotBezier(b)
        hold on
        narisi_premico(l)
        for i = Tp
            plot(i(1), i(2), 'ro')
        end
    end
end
    