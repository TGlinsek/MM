function [v] = poseben_primer(C, R)
    % poseben primer upogiba opne
    
    % f(r) ≡ C
    % R: polmer opne
    % vrne v(r)
    
    v = @(r) C/4 * (r^2 - R^2);
end

