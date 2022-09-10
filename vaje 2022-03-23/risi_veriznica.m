function [vozlisca] = risi_veriznica(zac, L, M, risanje)
    % zac = [x_0, x_n_1; y_0, y_n_1]
    % L
    % M

    if nargin < 4
        risanje = false;
    end
    



    W0 = [-1, -1];  % to je verjetno dober začetni približek za [u_0, v_0]
    
    vozlisca = ver_uv(W0, zac, L, M);  % 2 x (n + 2) matrika
    n = size(vozlisca, 2) - 2;

    x_0 = zac(1, 1);
    x_n_1 = zac(1, 2);
    y_0 = zac(2, 1);
    y_n_1 = zac(2, 2);

    vozlisca;
    
    if risanje
        hold on
        plot(vozlisca(1, 1), vozlisca(2, 1), 'o', 'color', 'blue');
        for i = 2 : n + 1
            plot(vozlisca(1, i), vozlisca(2, i), 'o', 'color', 'red');
        end
        plot(vozlisca(1, n + 2), vozlisca(2, n + 2), 'o', 'color', 'blue');
        
        for i = 1 : n + 1
            line(vozlisca(1, i:i+1), vozlisca(2, i:i+1), 'color', 'green');
        end
    end
end

