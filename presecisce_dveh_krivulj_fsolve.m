function presecisce = presecisce_dveh_krivulj_fsolve(p, q, sp_meja, zg_meja, X_0, risanje, options)
    % p, q krivulji (function handle)
    % X_0 ni vektor v 2D, priblizek presecisca, ampak leži v domeni funkcij
    % vrne eno presecisce

    if nargin < 7
        options = optimset('TolFun', 1e-16);
    end

    if nargin < 6
        risanje = false;
    end

    if nargin < 5
        X_0 = [0; 0];
    end

    if nargin < 3
        sp_meja = [0, 0];
        zg_meja = [1, 1];
    end

    
    razd = @(x) p(x(1)) - q(x(2));
    % options = optimset('TolFun', 1e-5);
    X = fsolve(razd, X_0, options);
    
    presecisce = p(X(1));  % lahko tudi q(X(2))
    % presecisce = q(X(2));
    
    
    if risanje
        figure
        t = linspace(sp_meja(1), zg_meja(1));  % to lahko spreminjaš
        hold on, grid on
        try
            a = p(t);
        catch
            a = p(t');
        end
        
        plot(a(1, :), a(2, :))
        
        t = linspace(sp_meja(2), zg_meja(2));

        try
            b = q(t);
        catch
            b = q(t');
        end
        
        
        plot(b(1, :), b(2, :))
        for i = size(presecisce, 2)
            plot(presecisce(1, i), presecisce(2, i), 'o')
        end
        axis equal
    end
end

