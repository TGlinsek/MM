function [rez] = odvod_Bernstein(b, t)
    % tak postopek se v praksi ne uporablja
    n = size(b, 2) - 1;
    rez = 0;
    for j = 0 : n - 1
        rez = rez + n * B(n - 1, j, t) * (b(:, j + 2) - b(:, j + 1));
    end
end

function vrednost = B(n, k, t)
    vrednost = nchoosek(n, k) * t^k * (1 - t)^(n - k);
end
