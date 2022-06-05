function [inverzna_funkcija] = inverz(f, priblizek_x)
    % iščemo x, da f^-1(y) = x, za vstavljen y
    % priblizek_x naj bo blizu x

    % za izračun več vrednosti je treba vstaviti vrstico
    % če vstavimo stolpec, je pa to evalviranje f v vektorju

    % inverzna_funkcija = @(y) fzero(@(x) f(x) - y, priblizek_x);
    % inverzna_funkcija = @(y) fsolve(@(x) f(x) - y, priblizek_x);  % ne deluje najboljš
    
    if nargin < 2
        inverzna_funkcija = @(y) dejanski_inverz(f, y);
    else
        inverzna_funkcija = @(y) dejanski_inverz(f, y, priblizek_x);
    end
end

function x = dejanski_inverz(f, y, priblizek_x)
    [m, n] = size(y);
    if nargin < 3
        priblizek_x = zeros(m, n);
    end
    x = zeros(m, n);  % nastavimo na nekaj, da ne povečuje seznama za vsako
    if m == 1
        for i = 1 : n
           x(:, i) = fzero(@(x) f(x) - y(:, i), priblizek_x(:, i));
        end
    else
        for i = 1 : n
           x(:, i) = fsolve(@(x) f(x) - y(:, i), priblizek_x(:, i));
        end
    end
end
