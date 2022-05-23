function [b] = C1CubicSpline(u, p, v, risanje)
    % b je dimenzije 2 x (3N + 1)
    N = size(p, 2) - 1;
    assert(size(p, 2) == size(v, 2), "Dolžini seznamov morata biti enaki!")
    assert(size(u, 2) == N + 1)
    
    b = [];
    for i = 1 : N
        b(:, end + 1) = p(:, i);
        delta_i = u(i + 1) - u(i);
        b(:, end + 1) = b(:, end) + delta_i/3 * v(:, i);
        b(:, end + 1) = p(:, i + 1) - delta_i/3 * v(:, i + 1);
    end
    b(:, end + 1) = p(:, N + 1);  % b je dimenzij 2 x (3N + 1)
    assert(size(b, 2) == 3*N + 1)
    
    
    if risanje
        for i = 1 : 3 : 3*N - 2
            hold on
            plotBezier(b(:, i : i + 3))  % zlepimo krivulje skupaj
        end
    end
end

