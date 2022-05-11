function P = mojrand(p, q, a, c, m, x_0)
    % vrne P iz R^{p x q} z naključnimi števili med 0 in 1
    % a, c, m parametri generatorja
    % x_0 seme
    zaporedje = Lehmer(a, c, m, x_0, p * q);
    P = reshape(zaporedje, p, q);  % al q, p? premisli
end

