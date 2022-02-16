function [F] = Fibonacci_rek(n)
    if n == 0 | n == 1
        F = n;
        return
    end
    F = Fibonacci_rek(n - 1) + Fibonacci_rek(n - 2);
end

