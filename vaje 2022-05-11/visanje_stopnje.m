function [nov_b] = visanje_stopnje(b)
    % b je 2 x (n + 1) matrika kontrolnih točk
    n = size(b, 2) - 1;
    nov_b = [[0; 0], b] .* (0 : n + 1)/(n + 1) + [b, [0; 0]] .* (1 - (0 : n + 1)/(n + 1));
end