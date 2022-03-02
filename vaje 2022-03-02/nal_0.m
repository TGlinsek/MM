% ''
dy = @(t, y) sin(t) + y
t = linspace(0, 2)
[~, y] = ode45(dy, t, 1)  % srednji argument bi lahko tudi izpustili in bi matlab sam ocenil, kaj je najboljše
figure
plot(t, y, 'linewidth', 2, 'color', [1 1 0])
hold off


% a
t = linspace(0, 5)
f = @(t, y) 2*t
[~, y] = ode45(f, t, 1)  % ta tretji argument 'c' je y(0) = c 
figure
plot(t, y, 'lineWidth', 2)
hold on
k = @(t) t.^2 + 1
plot(t, k(t), 'linewidth', 5, 'color', [0 1 0 0.5])

hold off
figure

% b
t = linspace(0, 5)
f = @(t, y) 6*t

F = @(t, Y) [Y(2) f(t, Y(1))]'
[~, y] = ode45(F, t, [1 0])  % zadnji argument so začetni pogoji [y1(0) y2(0)]
plot(t, y(:, 1), 'linewidth', 5, 'color', [1 0.7 0.7 0.8])  % lahka bi prva dva argumenta tudi transponirali, ali pa tudi samo enega
hold on
analiticna = @(t) t.^3 + 1
plot(t, analiticna(t), 'linewidth', 2, 'color', [1 1 0])
hold off


% bonus primera (nista z vaj)
% rešujemo y'' = t + y + y'


% y1 := y
% y2 := y'
t = linspace(0, 5)
f = @(t, y, y_) t + y + y_
F = @(t, Y) [Y(2) f(t, Y(1), Y(2))]'
[~, y] = ode45(F, t, [1 0])

figure
plot(t, y(:, 1), 'linewidth', 5, 'color', [1 0.7 0.7 0.8])
hold on

% analitična rešitev:
analiticna2 = @(t) sqrt((exp((1 + sqrt(5))*t))/5) - sqrt((exp((1 - sqrt(5))*t))/5) - t + 1
plot(t, analiticna2(t), 'linewidth', 2, 'color', [1 1 0])


% rešujemo y'' = t + 2*y + 3*y'

% y1 := y
% y2 := y'
t = linspace(0, 5)

f = @(t, y, y_) t + 2*y + 3*y_
F = @(t, Y) [Y(2) f(t, Y(1), Y(2))]'
[~, y] = ode45(F, t, [1 0])

figure
plot(t, y(:, 1), 'linewidth', 5, 'color', [1 0.7 0.7 0.8])
hold on

% analitična rešitev:
analiticna3 = @(x) (-(sqrt(17) - 1)/(8*sqrt(17)) + 1/4)*exp((3 + sqrt(17))*x/2) + (sqrt(17) - 1)/(8*sqrt(17))*exp((3 - sqrt(17))*x/2) - x/2 + 3/4
plot(t, analiticna3(t), 'linewidth', 3, 'color', [1 1 0])
