function [priblizek_za_pi] = racunanje_pi(N)
    x = rand(1, N);
    y = rand(1, N);
    booleani = x.^2 + y.^2 <= 1;
    K = sum(booleani);
    priblizek_za_pi = 4 * K/N;
end

% to je metoda 'zadeni in zgreši'