function [x] = resi(a, b, c, f)
    x = tridiagonalen_linearen_sistem(b', a', c', f');
end

