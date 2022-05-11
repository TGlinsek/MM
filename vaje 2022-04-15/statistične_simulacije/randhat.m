function [x] = randhat(n)
    % vrne x, ki je vektor velikosti n
    x = [];
    while length(x) < n
        x_koord = rand() * 2 - 1;
        y_koord = rand();

        if rhohat(x_koord) >= y_koord
            x(end + 1) = x_koord;
        end
    end

end

