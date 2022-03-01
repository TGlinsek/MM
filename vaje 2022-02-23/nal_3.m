f = @(r, fi) r .* fi;
r = linspace(1, 2);
fi = linspace(0, 10*pi);

[R, Fi] = ndgrid(r, fi)
F = f(R, Fi);
X = R.*cos(Fi);
Y = R.*sin(Fi);
surf(X, Y, F);  % vijačnica

hold off
shading interp