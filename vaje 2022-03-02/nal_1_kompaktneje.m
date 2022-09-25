%{
Feliks Vrtnar, svetovni znani padalec in adrenalinski zasvojenec, želi postaviti svetovni
rekord v hitrosti v prostem padu. 
Feliks si je zadal skočiti z balona z višine 40000 m nad tlemi. 
Pred skokom vas prosi, da opravite numerično simulacijo skoka, iz katerega
bi bilo bolj jasno, če bi predviden skok izpolnil njegova visoka pričakovanja.
Za osnovo vzemite simulacijski model, ki ste ga omenili na predavanjih: višino padalca
y opisuje enačba

y'' = -g - (ρ_z * c_u * S)/2m * y'|y'|

Vzemite g_0 = 9.81 m/s^2
za gravitacijski pospešek na nadmorski višini 0. Upoštevajte,
da Feliks skupaj z obleko in vso opremo tehta m = 105 kg. Prečna površina padalca
v smeri padanja je S = 1.2 m^2. Koeficient zračnega upora naj bo c_u = 1. Pri vsakem
vprašanju rešite diferencialno enačbo z vgrajeno metodo ode45. Diskretno rešitev (višino
in hitrost v odvisnosti od časa) poiščite na časovnem intervalu [0, t_K], kjer je t_K čas, na
katerega se navezuje vprašanje. Rešitev poiščite v 10000 enakomerno izbranih časovnih
točkah, vključno z začetno 0 in končno točko t_K. Za vsak primer narišite tudi graf višine
in hitrosti v odvisnosti od časa.
%}

% 1)
%{
Upoštevajte, da je gostota zraka povsod ρ_z = 1.225 kg/m^3
in gravitacijski pospešek
konstanten. Čas meritve naj bo 300 s. Kolikšna je povprečna hitrost (aritmetična
sredina) padalca, če pri izračunu upoštevate dobljene diskretne numerične vrednosti
v 10000 točkah?
%}

% y'(0) = 0

g_0 = 9.81;
ro_z = 1.225;  % ρ_z
c_u = 1;
S = 1.2;
m = 105;

t_K = 300;

g = g_0;

[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode45, true);

povp_hitrost = sum(y_)/length(y_);  % length(y_) je 10000
fprintf('Povprečna hitrost pride %.15f m/s.\n', povp_hitrost)  % zaokroži na 15 decimalnih mest, + 2 mesti pred piko
% pride -37.103943921425703


% 2)
%{
Kolikšna je teoretično maksimalna (končna) hitrost padalca, če uporabimo model
iz 1)?
%}

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
%{
Feliks s prvo simulacijo ni preveč zadovoljen, zato dopolnite simulacijski model.
Ker je skok iz precejšnje višine, ne smemo več predpostaviti, da je gravitacijski
pospešek neodvisen od višine. Pospešek se z višino spreminja kot
g(y) = g_0 * (r/(r + y))^2,
kjer je r = 6371 km povprečen radij Zemlje. Kolikšna je višina padalca po 300 s?
%}

r = 6371 * 1000;
g = @(y) g_0 .* (r./(r + y)).^2;

[y, ~] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode45, true);

fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride 2.892887963680784 * 10^4


% 4)
%{
Feliks je v skrbeh, ker rezultati simulacije niso vzpodbudni. Prijatelj meteorolog
vam posreduje podatke za gostoto zraka v odvisnosti od višine.

višina  [m]      |  0      2000   4000    6000    8000    10000   15000   20000    25000    30000    40000
gostota [kg/m^3] |  1.225  1.007  0.8194  0.6601  0.5258  0.4135  0.1948  0.08891  0.04008  0.01841  0.003996

Podatke aproksimirajte s polinomom

ρ_z(y) = a_0 + a_2 * ((y - 40000)/40000)^2 + a_4 * ((y - 40000)/40000)^4

po metodi najmanjših kvadratov (določite parametre a_0, a_2 in a_4) in predpostavite,
da se gostota zraka spreminja glede na dobljeno funkcijo ρ_z. Simulacijski model
nadgradite s to dodatno predpostavko. Kolikšna je višina padalca po 300 s v tem
primeru?
%}

visine = [0 : 2000 : 10000, 15000 : 5000 : 30000, 40000];
gostote = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];

ro_z = gostota_zraka(visine, gostote);

[y, ~] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode45, true);


fprintf("Višina padalca po %d sekundah je %.15d metrov.\n", t_K, y(end))
% pride              4.226372472678795e+03
% rešitev iz vaj je  4.226372472678798e+03


% 5
%{
Z dobljenim simulacijskim modelom je Feliks sedaj izredno zadovoljen. Vendar ga
zanimajo še dodatne informacije. Koliko bi padalec pridobil na hitrosti po 30 s, če
bi se ob skoku z balona odrinil navpično navzdol s hitrostjo −3 m/s, v primerjavi
s skokom brez odriva?
%}

t_K = 30;

[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, -3, @ode45, true);
hitrost_z_odrivom = y_(end);

[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode45, true);
hitrost_brez_odriva = y_(end);

fprintf("Razlika hitrosti padalca po %d sekundah glede na skok brez odriva je %.15f m/s.\n", t_K, hitrost_z_odrivom - hitrost_brez_odriva)
% pride -2.251586442889391 m/s


% 6
%{
Koliko časa preteče, ko padalec prvič doseže hitrost 300 m/s (pri skoku brez odriva)?
Rešitev poiščite tako, da definirate novo funkcijo fun1, ki preko klica funkcije ode45
za vhodni podatek t_K vrne hitrost ob času t_K. Nato uporabite vgrajeno funkcijo
fzero, da poiščete ničlo funkcije fun2, ki ima ničlo ravno pri tistem argumentu,
pri katerem ima fun1 vrednost 300.
%}

fun2 = @(t) fun1(t, g, ro_z, c_u, S, m) + 300;  % iščemo hitrost -300
T = fzero(fun2, 30);
fprintf("Hitrost 300 m/s padalec doseže po %.14f sekundah.\n", T)

function v = fun1(t_K, g, ro_z, c_u, S, m)  % hitrost ob t_K
    [~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0);
    v = y_(end);
end
% pride             34.81280761424303
% rešitev iz vaj je 34.81280761423394
