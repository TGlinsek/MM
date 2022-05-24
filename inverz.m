function [inverz] = inverz(f, priblizek_x)
    % iščemo x, da f^-1(y) = x, za vstavljen y
    % priblizek_x naj bo blizu x

    if nargin < 2
        priblizek_x = 0;
    end
    
    inverz = @(y) fzero(@(x) f(x) - y, priblizek_x);
end

