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

%{
indeks = @(tabela, i) tabela(i)

% grda, toda enovrstična koda (če ne štejemo definicije indeksa zgoraj):
g = @(x, y) indeks([reshape(f(x, y), 1, []) 1], reshape(1 : numel(f(x, y)), size(f(x, y))) - isnan(f(x, y)) .* reshape(-numel(f(x, y)) : -1, size(f(x, y))))

surf(A, B, g(A, B))
shading interp
%}
G = f(A, B)
N = isnan(G)
G(N) = 1

surf(A, B, G)
xlabel('x')
ylabel('y')
shading interp

% c
F = @(x) f(x(1), x(2))  % funkcija, ki jo vnašamo v fmincon, mora imeti le en parameter
[x_min, y_min] = fmincon(F, [1/2 1/2], [0 0; 0 0], [0 0], [0 0; 0 0], [0 0], [0 0], [1 2])
% F(x_min) == y_min
[x_max, y_max_minus] = fmincon(@(x) -F(x), [1/2 1/2], [0 0; 0 0], [0 0], [0 0; 0 0], [0 0], [0 0], [1 2])
y_max = -y_max_minus
% F(x_max) == y_max

hold on
plot3(x_min(1), x_min(2), y_min, 'o', 'color', 'red')
plot3(x_max(1), x_max(2), y_max, 'o', 'color', 'red')

% d
% ni čist tk rešeno, kot je blo mišljeno

% izberi točki x iz [0, 1] in y iz [0, 2]
x = 3/4
y = 5/4
% gradient v točki [x y]


x_ = x / h + 1  % lahko se zgodi, da to ne bo celo število
y_ = y / h + 1


% namesto f(A, B) vnesemo kar G (isto, le brez lukenj)
[FY, FX] = gradient(G)
% gradient je mal čudna funkcija in je ne razumem čist
% vrne [FY FX] namest [FX FY], čeprav v dokumentaciji piše drugače
% lahk da je G narobe definiran

FX = FX./h
FY = FY./h

%{
figure
surf(A, B, G)
xlabel('x')
shading interp
%}

dx = FX(x_, y_)
dy = FY(x_, y_)

tocka = [x, y, f(x, y)]
smerni_vektor_normale = [-dx, -dy, 1]./sqrt(dx^2 + dy^2 + 1)
%{
quiver3(tocka(1), tocka(2), tocka(3), ...
    smerni_vektor_normale(1), smerni_vektor_normale(2), smerni_vektor_normale(3), ...
    'color', 'red')
%}


    