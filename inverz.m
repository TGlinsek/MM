function [rezultat] = inverz(f, priblizek_x, y0)
    % iščemo x, da f^-1(y) = x, za vstavljen y
    % priblizek_x naj bo blizu x

    % če hočemo, da priblizek_x interval, potem moramo ta interval napisati
    % kot stolpec: [a; b] predstavlja interval [a, b].


    % za izračun več vrednosti je treba vstaviti vrstico
    % če vstavimo stolpec, je pa to evalviranje f v vektorju

    % inverzna_funkcija = @(y) fzero(@(x) f(x) - y, priblizek_x);
    % inverzna_funkcija = @(y) fsolve(@(x) f(x) - y, priblizek_x);  % ne
    % deluje najboljš, ampak dobr
    
    assert(nargin >= 1, "Funkcija potrebuje vsaj dva parametra.")
    
    if nargin == 1
        priblizek_x = [];  % to naj bo default, tk ko None v pythonu
    end

    if isempty(priblizek_x)
        priblizek_x = [0];  % default začetni približek (deluje le za funkcije, ki sprejemajo števila (niso vektorske funkcije))
    end

    pogoj_je_interval = false;
    
    try
        f(priblizek_x(1, 1));  % če je tu error, potem se dimenzija približka ne ujema z dimenzijo pričakovanega parametra funkcije f
        assert(size(priblizek_x, 1) == 2, "Priblizek_x mora imeti le eno ali pa dve vrstici (če nastavljamo interval iskanja ničle).")
        pogoj_je_interval = true;
        % fprintf("\nKot pogoj ste podali interval! \n")
    catch
        f(priblizek_x(:, 1));  % če je tu error, potem se dimenzija približka ne ujema z dimenzijo pričakovanega parametra funkcije f
        % pogoj_je_interval = false;  % je že false tukaj
        % fprintf("\nKot pogoj ste podali vrednost! \n")
    end
    inverzna_funkcija = @(y) dejanski_inverz(f, y, priblizek_x, pogoj_je_interval);


    if nargin < 3
        rezultat = inverzna_funkcija;
    else
        rezultat = inverzna_funkcija(y0);
    end
end

function x = dejanski_inverz(f, y, priblizek_x, pogoj_je_interval)
    [m, n] = size(y);
    [m_, n_] = size(priblizek_x);
    if n_ == 1
        priblizek_x = priblizek_x * ones(1, n);
    end
    assert(n_ == n || n_ == 1, "Priblizek mora imeti enako število stolpcev kot y (ki je argument inverzne funkcije)!")
    if pogoj_je_interval
        m_ = 1;
    end
    
    [m__, n__] = size(f(priblizek_x(1:m_, 1)));

    assert(m__ == m, "Izhod funkcije f mora biti enakih dimenzij kot y (ki je argument inverzne funkcije)!")
    assert(n__ == 1, "Popravi funkcijo f, saj če vstavimo vektor, vrne matriko.")
    
    % x = zeros(m_, n);  % nastavimo na nekaj, da ne povečuje seznama za vsako
    if m == 1 && m_ == 1
        
        for i = 1 : n
            x(:, i) = fzero(@(x) f(x) - y(:, i), priblizek_x(:, i)');% če je napaka tukaj, potem morda inverz v tej točki ne obstaja
            % specifično, če je ta napaka "Function values at the interval
            % endpoints must differ in sign.", potem inverz ne obstaja
        end
        
        % x = razbijalec(@(y) fzero(@(x) f(x') - y, priblizek_x), y);  % če je napaka tukaj, potem morda inverz v tej točki ne obstaja
        % ne deluje, če priblizek_x seznam približkov
    else
        options = optimset('Display','off');
        for i = 1 : n
            x(:, i) = fsolve(@(x) f(x) - y(:, i), priblizek_x(:, i), options);
        end
        
        % x = razbijalec(@(y) fsolve(@(x) f(x) - y, priblizek_x, options), y);
    end
end
