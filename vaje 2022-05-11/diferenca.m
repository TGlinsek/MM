function [iskana_diferenca] = diferenca(bx, by, k, j)
    % vrne Δ^k P_j, kjer j = 0, 1, ..., n
    % bx in by lahko imata veliko vrstic. Vsaka vrstica predstavlja neko
    % množico kontrolnih točk

    assert(size(bx, 1) == size(by, 1))
    % s = size(bx, 1);
    n = size(bx, 2) - 1;
    assert(size(bx, 2) == size(by, 2))

    assert(0 <= k, "Moralo bi veljati 0 <= k.")
    assert(0 <= j, "Moralo bi veljati 0 <= j.")
    assert(j + k <= n, "Diferenca ne obstaja!")
    for i = 1 : k
        bx = bx(:, 2:end) - bx(:, 1:end - 1);
        by = by(:, 2:end) - by(:, 1:end - 1);
    end

    iskana_diferenca_x = bx(:, j + 1);  % vektor dolžine s
    iskana_diferenca_y = by(:, j + 1);
    
    iskana_diferenca = [iskana_diferenca_x'; iskana_diferenca_y'];  % 2 x s
end

