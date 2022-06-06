% 1)
% y'(0) = 0

g_0 = 9.81;
ro_z = 1.225;
c_u = 1;
S = 1.2;
m = 105;

t_K = 300;

g = g_0;

[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, true);

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

[y, ~] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, true);

fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride 2.892887963680784 * 10^4


% 4)
visine = [0 : 2000 : 10000, 15000 : 5000 : 30000, 40000];
gostote = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];

ro_z = gostota_zraka(visine, gostote);

[y, ~] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, true);


fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride             4.226372472678795e+03
% rešitev iz vaj je  4.226372472678798e+03


% 5
t_K = 30;

[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, -3, true);
hitrost_z_odrivom = y_(end);

[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, true);
hitrost_brez_odriva = y_(end);

fprintf("Razlika hitrosti padalca po %d sekundah glede na skok brez odriva je %.15f m/s.\n", t_K, hitrost_z_odrivom - hitrost_brez_odriva)
% pride -2.251586442889391 m/s


% 6
fun2 = @(x) fun1(x, g, ro_z, c_u, S, m) + 300;  % iščemo hitrost -300
T = fzero(fun2, 30);
fprintf("Hitrost 300 m/s padalec doseže po %.14f sekundah.\n", T)

function v = fun1(t_K, g, ro_z, c_u, S, m)  % hitrost ob t_K
    [~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0);
    v = y_(end);
end
% pride             34.81280761424303
% rešitev iz vaj je 34.81280761423394
