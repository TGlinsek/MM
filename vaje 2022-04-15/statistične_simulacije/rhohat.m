function [y] = rhohat(x)
    if -1 <= x && x <= 0
        y = x + 1;
    elseif 0 < x && x <= 1
        y = 1 - x;
    end
end

