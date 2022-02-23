f = @(r, fi) r .* fi;
r = linspace(1, 2);
fi = linspace(0, 10*pi);
x = r.*cos(fi);
y = r.*sin(fi);

g = @(x, y) f(sqrt(x.^2 + y.^2), atan(y./x));
[A, B] = ndgrid(x, y);
surf(x, y, g(A, B))
hold off
plot3(x, y, g(A, B))
% popravi