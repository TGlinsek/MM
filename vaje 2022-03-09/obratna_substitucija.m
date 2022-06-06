function [x] = obratna_substitucija(U, y)
    % rešujemo Ux = y v x

    if height(y) < width(y)
        y = y';
    end

    assert(size(U)*[1; -1] == 0, "Matrika ni kvadratna!");  % preverimo, če je U res kvadratna
    n = length(U);
    assert(sum([n 1] == size(y)) == 2, "Argumenta nista iste višine!");  % preverimo, da y prave dolžine
    assert(all(all(U == triu(U))), "Matrika mora biti zgornje trikotna!")  % preverimo, če je U res zgornje trikotna


    Z = flip(eye(n));
    x = Z*prema_substitucija(Z*U*Z, Z*y);
end

