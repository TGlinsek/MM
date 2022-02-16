function [A] = blocna(n)
    T = diag(-4*ones(n, 1));
    T = T + diag(ones(n - 1, 1), 1);
    T = T + diag(ones(n - 1, 1), -1);

    A = zeros(n^2);
    
    % TODO: spravi v en sam for loop
    for i = 1:n
        vektor_n = (i - 1)*n + 1:i*n;
        A(vektor_n, vektor_n) = T;
    end

    for i = 1:n-1
        vektor_n = (i - 1)*n + 1:i*n;
        A(vektor_n+n, vektor_n) = eye(n);  % vektor_n + n prišteje n vsakemu
        % elementu vektorja
    end

    for i = 1:n-1
        vektor_n = (i - 1)*n + 1:i*n;
        A(vektor_n, vektor_n+n) = eye(n);
    end
end

