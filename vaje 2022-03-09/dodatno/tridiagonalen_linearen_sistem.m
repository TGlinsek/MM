function [x] = tridiagonalen_linearen_sistem(D, P, N, b)
    % rešujemo Tx = b, kjer T tridiagonalna

    assert(length(D) == length(b), "Dimenziji leve in desne strani sistema se ne ujemata!")

    [L, U] = LU_razcep_tridiagonalne_matrike(D, P, N);

    % rešujemo LUx = b
    y = prema_substitucija(L, b);
    x = obratna_substitucija(U, y);
end

