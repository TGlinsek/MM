% a)
x = linspace(1, 3);
f = @(x)sin(x).*exp(sqrt(x));
plot(x, f(x), 'color', [0 0 1]);
hold on  % da se ne briše za vsako

% b)
t = linspace(0, 2*pi);
g_x = @(t) cos(t);
g_y = @(t) sin(t);
plot(g_x(t), g_y(t), 'color', [1 0 0])
hold off

% c)
t = linspace(0, 10*pi);
h_x = @(t) cos(t);
h_y = @(t) sin(t);
h_z = @(t) t;
plot3(h_x(t), h_y(t), h_z(t), 'color', [0 1 0])

% d)
x = linspace(0, 1);
y = linspace(0, 1);
k = @(x, y) (x.^2 + y.^2)./(1 + x + y);
plot3(x, y, k(x, y), 'color', [1 0 1])