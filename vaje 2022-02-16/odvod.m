function [p_] = odvod(p)
    n = length(p) - 1
    p_ = (p(1:end-1) .* (n : -1 : 1))
end

