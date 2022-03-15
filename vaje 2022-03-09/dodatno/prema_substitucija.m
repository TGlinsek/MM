function [y] = prema_substitucija(L, b)
    % rešujemo Ly = b v y

    if height(b) < width(b)
        b = b';
    end

    assert(size(L)*[1; -1] == 0, "Matrika ni kvadratna!")  % preverimo, če je L res kvadratna
    n = length(L);
    assert(sum([n 1] == size(b)) == 2, "Argumenta nista iste višine!")  % preverimo, da b prave dolžine
    assert(all(all(L == tril(L))), "Matrika mora biti spodnje trikotna!")  % preverimo, če je L res spodnje trikotna

    y = zeros(1, length(L))';

    for i = 1 : n
        y(i) = (b(i) - L(i, 1:i - 1) * y(1:i - 1))/L(i, i);
    end
    % za i = 0 se zgodi skalarni produkt praznih vektorjev, kar nam da 0,
    % zato se tudi v tem primeru račun izide

end

