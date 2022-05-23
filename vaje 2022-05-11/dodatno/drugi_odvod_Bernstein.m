function [rez] = drugi_odvod_Bernstein(b, t)
    % tak postopek se v praksi ne uporablja
    n = size(b, 2) - 1;
    rez = 0;
    for j = 0 : n - 2
        rez = rez + n * (n - 1) * B(n - 2, j, t) * (b(:, j + 3) - 2*b(:, j + 2) + b(:, j + 1));
    end
end

function vrednost = B(n, k, t)
    vrednost = nchoosek(n, k) * t^k * (1 - t)^(n - k);
end
