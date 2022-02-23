f = @(x, y) sin(x.^2 - y.^4)./(x.^2 - y.^4);
% g = @(x, y) (x.^2 - y.^4 == 0) : 1 : f(x, y)

x = linspace(0, 1)
y = linspace(0, 2)

% h = 0.01 lahko dosežemo takole:
% x = 0 : 0.01 : 1
% y = 0 : 0.01 : 2

[A, B] = ndgrid(x, y);
surf(x, y, f(A, B))
shading interp