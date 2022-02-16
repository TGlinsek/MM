function [A] = nal_5_fun(m, n)
    % m x n <-> m vrstic, n stolpcev
    % A(i, j) = i. vrsta, j. stolpec
    A = (1 : m)' * (1 : n) + (1 + 1 : m + 1).^(-3)' * (1 - 4: n - 4).^2;

    % preverimo, da res pride isto
    %{
    B = zeros(m, n);
    for i = 1:m
        for j = 1:n
            B(i, j) = (j - 4)^2*(i+1)^(-3) + i*j;
        end
    end
    %}
    
end

