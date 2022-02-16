function [X] = suma(a, s)
    % a naraščajoča (ne nujno strogo naraščajoča)
    i = 1;
    j = length(a);
    X = [];

    while i < j
        if a(i) + a(j) < s
            i = i + 1;
        elseif a(i) + a(j) > s
            j = j - 1;
        else
            nov_par = [a(i), a(j)];
            % velja X(1, end) == nov_par(1) iff X(2, end) == nov_par(2)
            if isempty(X) | X(:, end) ~= nov_par
                % nočemo dvojnikov
                X(:, end + 1) = nov_par;
            end
            % X(end + 1) = nov_par ne deluje
            i = i + 1;
            j = j - 1;
        end
    end
end

