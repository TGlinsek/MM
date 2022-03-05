% risanje ploskve, parametrizirane s kartezičnimi koordinatami
f = @(x, y) sin(x).*cos(x)
[X, Y] = ndgrid(linspace(0, 1), linspace(2, 3))
surf(X, Y, f(X, Y))
shading interp