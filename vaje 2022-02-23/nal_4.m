f = @(x, y) sin(x.^2 - y.^4)./(x.^2 - y.^4);


% x = linspace(0, 1)
% y = linspace(0, 2)

h = 0.01 % lahko dosežemo takole:
x = 0 : h : 1
y = 0 : h : 2

[A, B] = ndgrid(x, y);
surf(A, B, f(A, B))
shading interp
hold off
% b

indeks = @(tabela, i) tabela(i)

% grda, toda enovrstična koda (če ne štejemo definicije indeksa zgoraj):
g = @(x, y) indeks([reshape(f(x, y), 1, []) 1], reshape(1 : numel(f(x, y)), size(f(x, y))) - isnan(f(x, y)) .* reshape(-numel(f(x, y)) : -1, size(f(x, y))))

surf(A, B, g(A, B))
shading interp
