% ni naloga iz vaj
function [f] = Fibonacci_rek_memo()
    X = [0, 1];
    f = @Fibonacci_rek;
    function [F] = Fibonacci_rek(n)
        if length(X) > n
            F = X(n + 1);
            return
        end
        F = Fibonacci_rek(n - 2) + Fibonacci_rek(n - 1);
        X(n + 1) = F;
    end
end

