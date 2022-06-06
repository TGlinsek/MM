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

% y = y_in_y_(:, 1);
y_ = y_in_y_(:, 2);

%{
plot(t, y);
hold on
plot(t, y_)
%}
povp_hitrost = sum(y_)/length(y_);  % length(y_) je 10000
fprintf('Povprečna hitrost pride %.15f m/s.\n', povp_hitrost)  % zaokroži na 15 decimalnih mest, + 2 mesti pred piko
% pride -37.103943921425703


% 2)
% v limiti se bo hitrost ustalila na neki vrednosti, torej je pospešek 0
% torej je y'' = 0
% zdaj pa čist algebraično (ne numerično) rešimo enačbo, da izrazimo y'
% pride y'*abs(y') = -g_0/(ro_z * c_u * S/(2*m))
% desna stran je negativna, torej bo y' negativen (no, to smo že vedeli)
% torej y' = -sqrt(g_0/(ro_z * c_u * S/(2*m)))
y_ = -sqrt(g_0/(ro_z * c_u * S/(2*m)));
fprintf('Limitna hitrost pride %.15f m/s.\n', y_)
% pride -37.435659089009924


% 3)
r = 6371 * 1000;
g = @(y) g_0 .* (r./(r + y)).^2;

f = @(y, y_) nekonkreten_f(g(y), ro_z, c_u, S, m, y_);

F = @(t, Y) [Y(2) f(Y(1), Y(2))]';
[~, y_in_y_] = ode45(F, t, [40000 0]);

y = y_in_y_(:, 1);
% y_ = y_in_y_(:, 2);

%{
figure
plot(t, y);
hold on
plot(t, y_)
%}
fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride 2.892887963680784 * 10^4


% 4)
visine = [0 : 2000 : 10000, 15000 : 5000 : 30000, 40000];
gostote = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];


transformacija = @(x) ((x - 40000)./40000).^2;
visine = transformacija(visine);
% A = [(1 : length(visine))', visine', visine.^2'];  % alternativna metoda
% za najmanjše kvadrate, ampak očitno ne dela čist prav. Bolje: polyfit
% x = lsqr(A, gostote');  % least squares

x = flip(polyfit(visine, gostote, 2))';  % boljši least squares

% naš polinom:
ro_z = @(y) x(1) + x(2).*transformacija(y) + x(3).*transformacija(y).^2;


f = @(y, y_) nekonkreten_f(g(y), ro_z(y), c_u, S, m, y_);

F = @(t, Y) [Y(2) f(Y(1), Y(2))]';
[~, y_in_y_] = ode45(F, t, [40000 0]);
y = y_in_y_(:, 1);
% y_ = y_in_y_(:, 2);

%{
figure
plot(t, y);
hold on
plot(t, y_)
%}
fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride             4.226372472678795e+03
% rešitev iz vaj je  4.226372472678798e+03


% 5
t_K = 30;
t = linspace(0, t_K, 10000);

[~, y_in_y_] = ode45(F, t, [40000 -3]);  % začetna hitrost 3 m/s navzdol
% y = y_in_y_(:, 1);
y_ = y_in_y_(:, 2);

hitrost_z_odrivom = y_(end);

[~, y_in_y_] = ode45(F, t, [40000 0]);
% y = y_in_y_(:, 1);
y_ = y_in_y_(:, 2);

hitrost_brez_odriva = y_(end);

fprintf("Razlika hitrosti padalca po %d sekundah glede na skok brez odriva je %.15f m/s.\n", t_K, hitrost_z_odrivom - hitrost_brez_odriva)
% pride -2.251586442889391 m/s


% 6
fun2 = @(x) (fun1(x, F) + 300);  % iščemo hitrost -300
T = fzero(fun2, 30);
fprintf("Hitrost 300 m/s padalec doseže po %.14f sekundah.\n", T)

function v = fun1(t_K, F)  % hitrost ob t_K
    t = linspace(0, t_K, 10000);
    [~, y_in_y_] = ode45(F, t, [40000 0]);
    % y = y_in_y_(:, 1);
    y_ = y_in_y_(:, 2);
    v = y_(end);
end
% pride             34.81280761424303
% rešitev iz vaj je 34.81280761423394
