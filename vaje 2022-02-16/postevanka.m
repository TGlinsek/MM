function [A] = postevanka(a, b)
    % velikost a x b <-> a vrstic, b stolpcev
    A = (1 : a)' * (1 : b);
end

