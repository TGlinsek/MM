function [A] = nal_2_fun(n)
    A = triu(4*ones(n), 1);
    A = A + diag(1:n);
    A = A + tril(triu(ones(n), -1), -1);
    A = A + tril(triu(-ones(n), -2), -2);
end

