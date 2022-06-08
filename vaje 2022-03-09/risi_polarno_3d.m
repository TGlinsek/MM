function risi_polarno_3d(f, r1, r2, fi1, fi2)
    % f = f(r, fi) oz. f = [f(r1, f1), ..., f(r1, f2); ...; f(r2, f1), ..., f(r2, f2)]
    % r-ji in fi-ji morajo biti enakomerno razporejeni po intervalih
    % [r1, r2], [fi1, fi2]

    % če f navpičen vektor, potem je f odvisen le od r
    % če f podolgovat vektor, potem je f odvisen le od fi

    % to dvoje lahko štelamo:
    default_m = 100;  % tolk naj bo različnih r-jev
    default_n = 100;  % tolk naj bo različnih kotov

    if ~isa(f, 'function_handle')
        [m, n] = size(f);

        % če ima f katero izmed dimenzij netrivialno, potem nam ta
        % dimenzija da število podatkov v tej smeri. Zato spremenimo
        % default_m in default_n
        if n == 1  % navpičen vektor
            f = f * ones(1, default_n);
        else
            default_n = n;
        end

        if m == 1  % vodoraven vektor
            f = ones(default_m, 1) * f;
        else
            default_m = m;
        end
    end

    r = linspace(r1, r2, default_m);
    fi = linspace(fi1, fi2, default_n);
    
    [R, Fi] = ndgrid(r, fi);
    X = R.*cos(Fi);
    Y = R.*sin(Fi);

    if isa(f, 'function_handle')
        F = f(R, Fi);
    else
        F = f;
    end

    surf(X, Y, F);
    shading interp
end

