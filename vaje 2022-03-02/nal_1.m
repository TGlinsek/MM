% 1)
% y'(0) = 0
g_0 = 9.81;
ro_z = 1.225;
c_u = 1;
S = 1.2;
m = 105;

t_K = 300;
t = linspace(0, t_K, 10000);

nekonkreten_f = @(g, ro_z, c_u, S, m, y_) -g - (ro_z .* c_u .* S./(2.*m)).*y_.*abs(y_);
f = @(y_) nekonkreten_f(g_0, ro_z, c_u, S, m, y_);  % konkreten f
F = @(t, Y) [Y(2) f(Y(2))]';
[~, y_in_y_] = ode45(F, t, [40000 0]);  % čeprav v teoriji začetni pogoj
% za y ne vpliva, se dejansko ode45 drugače obnaša, če damo namesto 40000
% kako drugo cifro

% y je pot, y_ pa hitrost
y = y_in_y_(:, 1);
y_ = y_in_y_(:, 2);

plot(t, y);
hold on
plot(t, y_)
povp_hitrost = sum(y_)/length(y_);  % length(y_) je 10000
fprintf('Povprečna hitrost pride %2.15f\n', povp_hitrost)  % zaokroži na 15 decimalnih mest, + 2 mesti pred piko
% pride -37.103943921425703

% 2)
% v limiti se bo hitrost ustalila na neki vrednosti, torej je pospešek 0
% torej je y'' = 0
% zdaj pa čist algebraično (ne numerično) rešimo enačbo, da izrazimo y'
% pride y'*abs(y') = -g_0/(ro_z * c_u * S/(2*m))
% desna stran je negativna, torej bo y' negativen (no, to smo že vedeli)
% torej y' = -sqrt(g_0/(ro_z * c_u * S/(2*m)))
y_ = -sqrt(g_0/(ro_z * c_u * S/(2*m)));
fprintf('Limitna hitrost pride %2.15f\n', y_)
% pride -37.435659089009924

% 3)
r = 6371 * 1000;
g = @(y) g_0 .* (r./(r + y)).^2;

f = @(y, y_) nekonkreten_f(g(y), ro_z, c_u, S, m, y_);

F = @(t, Y) [Y(2) f(Y(1), Y(2))]';
[~, y_in_y_] = ode45(F, t, [40000 0]);

y = y_in_y_(:, 1);
y_ = y_in_y_(:, 2);

figure
plot(t, y);
hold on
plot(t, y_)
fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride 2.892887963680784 * 10^4

% 4)
visine = [0 : 2000 : 10000, 15000 : 5000 : 30000, 40000];
gostote = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];
n = length(visine);
transformacija = @(x) ((x - 40000)./40000).^2;
visine = transformacija(visine);
A = [(1 : n)', visine', visine.^2'];
x = lsqr(A, gostote');  % least squares
% naš polinom:
ro_z = @(y) x(1) + x(2).*transformacija(y) + x(3).*transformacija(y).^2;


f = @(y, y_) nekonkreten_f(g(y), ro_z(y), c_u, S, m, y_);

F = @(t, Y) [Y(2) f(Y(1), Y(2))]';
[~, y_in_y_] = ode45(F, t, [40000 0]);
y = y_in_y_(:, 1);
y_ = y_in_y_(:, 2);

figure
plot(t, y);
hold on
plot(t, y_)
fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride napačnih 3.883342248396916e+03. Prav naj bi blo 4.226372472678798e+03
