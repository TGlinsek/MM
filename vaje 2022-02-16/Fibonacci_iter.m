function [F] = Fibonacci_iter(n)
    X = [0, 1];
    for i = 1:n - 1
        X(i + 2) = X(i + 1) + X(i);
    end
    F = X(n + 1);
end

