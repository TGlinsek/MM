addpath(genpath('..\..'))

%{
Feliks Vrtnar, svetovni znani padalec in adrenalinski zasvojenec, želi postaviti svetovni rekord v hitrosti v prostem padu. 
Feliks si je zadal skočiti iz balona z višine 40000 m nad tlemi. 
Pred skokom vas prosi, da opravite numerično simulacijo skoka, iz katerega bi bilo bolj jasno, 
če bi predviden skok izpolnil njegova visoka pričakovanja. 
Vzemite g_0 = 9.81 m/s^2 za pospešek na nadmorski višini 0. 
Pospešek se z višino spreminja po formuli g(h) = g_0 * (r/(r+h))^2, kjer je r = 6371 km povprečen radij Zemlje. 
Upoštevajte, da Feliks skupaj z obleko in vso opremo tehta 90.0 kg. 
Prečna površina padalca v smeri padanja je 0.9 m^2. 
Koeficient zračnega upora naj bo 1.0. 
Gostota zraka se spreminja v odvisnosti od višine glede na spodnjo tabelo (enako kot v domači nalogi)

[višina [m]  0  2000  4000  6000  8000  10000  15000  20000  25000  30000  40000]
[gostota [kg/m^3]  1.225  1.007  0.8194  0.6601  0.5258  0.4135  0.1948  0.08891  0.04008  0.01841  0.003996]

Podatke aproksimirajte s polinomom
ρ(h) = a_0 + a_2*((h − 40000)/40000)^2 + a_4*((h − 40000)/40000)^4
po metodi najmanjših kvadratov (določite parametre a_0, a_2 in a_4).
Pri vsakem vprašanju rešite diferencialno enačbo z vgrajeno metodo ode23s, 
ki se jo kliče in deluje enako ode45. 
Da bo možnost razlike v numeričnih odgovorih manjša, pri vsaki nalogi 
poiščite diskretno rešitev na izbranem časovnem intervalu, sestavljenem iz 
10000 enakomerno razporejenih točk, vključno z začetno in končno točko.
%}

visine = [0 : 2000 : 10000, 15000 : 5000 : 30000, 40000];
gostote = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];

g_0 = 9.81;
ro_z = gostota_zraka(visine, gostote);
c_u = 1;
S = 0.9;
m = 90;

r = 6371 * 1000;
g = @(y) g_0 .* (r./(r + y)).^2;


% 1)
%{
Izračunajte dolžino prepotovane poti po 25 s.
%}
t_K = 25;

y = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode23s, true);
40000 - y(end)  % 2.952853204605366e+03


% 2)
%{
Za koliko bi se absolutno spremenila končna hitrost padalca po 60 s, če bi 
se padalec dodatno obtežil s 100 kg, dodatna oprema pa bi povečala 
koeficient upora in površino padalca za 0.1?
%}

t_K = 60;
[~, y1_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode23s, true);
[~, y2_] = feliks(g, ro_z, c_u + 0.1, S + 0.1, m + 100, 10000, t_K, 40000, 0, @ode23s, true);
y1_(end) - y2_(end)  % 55.704796312524536


% 3)
%{
Določite največjo hitrost padalca (brez dodatnih obtežil). Pomagate si 
lahko npr. s funkcijo fminbnd
%}

hitrost = @(t) fun1(t, g, ro_z, c_u, S, m);
hitrost(fminbnd(hitrost, 0, 300))  % -3.605088194605596e+02


% 4)
%{
Po t_opt s padanja padalec v trenutku odpre padalo. Na ta način se poveča 
prečna površina padalca za 10m^2, koeficient zračnega upora pa se poveča za 
petkrat. Koliko mora biti t_opt, da bo padalec po 400 s od skoka z balona 
ravno dosegel površje Zemlje?
%}

% prvotni način:
% pot = @(t_opt) fun_pot(t_opt, g, ro_z, c_u, S, m);
% hitrost = @(t_opt) fun_hit(t_opt, g, ro_z, c_u, S, m);

pot = @(t_opt) feliks(g, ro_z, c_u, S, m, 10000, t_opt, 40000, 0, @ode23s, false, false, true);  % pot do odprtja padala
hitrost = @(t_opt) feliks(g, ro_z, c_u, S, m, 10000, t_opt, 40000, 0, @ode23s, false, true, true);  % hitrost ob odprtju padala

% pot od odprtja padala naprej pa do takrat ko mine 400 s
pot_2 = @(t_opt) feliks(g, ro_z, 5*c_u, S + 10, m, 10000, 400 - t_opt, pot(t_opt), hitrost(t_opt), @ode23s, false, false, true);
razdalja = @(t_opt) 40000 - pot_2(t_opt);
fzero(@(t_opt) razdalja(t_opt) - 40000, [0.1, 399.9])  % 3.735512518554606e+02


function v = fun1(t_K, g, ro_z, c_u, S, m)  % za tretjo nalogo
    [~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode23s);
    v = y_(end);
end

% prvotni način:
%{
function s = fun_pot(t_opt, g, ro_z, c_u, S, m)
    y = feliks(g, ro_z, c_u, S, m, 10000, t_opt, 40000, 0, @ode23s);
    s = y(end);
end

function v = fun_hit(t_opt, g, ro_z, c_u, S, m)
    [~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_opt, 40000, 0, @ode23s);
    v = y_(end);
end
%}