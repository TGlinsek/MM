function [tez_x, tez_y, potencialna_energija] = tezisce(vozlisca, M)
    g = 9.81;
    assert(size(vozlisca, 2) == size(M, 2) + 1, "Vozlišča morajo vsebovati tudi obe obesišči.")

    T1 = vozlisca(:, 1);
    T2 = vozlisca(:, end);
    vozlisca_x = vozlisca(1, :);
    vozlisca_y = vozlisca(2, :);

    tezisca_x = ([T1(1), vozlisca_x] + [vozlisca_x, T2(1)])/2;
    tezisca_x = tezisca_x(2 : end - 1);

    tezisca_y = ([T1(2), vozlisca_y] + [vozlisca_y, T2(2)])/2;
    tezisca_y = tezisca_y(2 : end - 1);
    
    tez_x = sum(M.*tezisca_x)/sum(M);
    tez_y = sum(M.*tezisca_y)/sum(M);
    
    potencialna_energija = g*sum(M.*tezisca_y);
end

