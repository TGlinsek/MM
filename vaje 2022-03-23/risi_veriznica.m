function [] = risi_veriznica(zac, L, M)
    % zac = [x_0, x_n_1; y_0, y_n_1]
    % L
    % M

    

    W0 = [-1, -1];  % to je verjetno dober začetni približek za [u_0, v_0]
    vozlisca = ver_uv(W0, zac, L, M);  % 2 x (n + 2) matrika
    
    n = length(vozlisca) - 2;

    x_0 = zac(1, 1)
    x_n_1 = zac(1, 2)
    y_0 = zac(2, 1)
    y_n_1 = zac(2, 2)

    vozlisca
    hold on
    for i = 1 : n + 2
        plot(vozlisca(1, i), vozlisca(2, i), 'o', 'color', 'red');
    end
    
    for i = 1 : n + 1
        line(vozlisca(1, i:i+1), vozlisca(2, i:i+1), 'color', 'green');
    end


end

