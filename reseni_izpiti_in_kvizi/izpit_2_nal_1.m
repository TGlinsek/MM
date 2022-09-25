addpath(genpath('..'))

%{
Naj bo g_0 = 9.81 m/s^2 za pospešek na nadmorski višini 0. Pospešek se z višino spreminja po formuli g(h) = g_0 * (r/(r+h))^2, kjer je r = 6371 km povprečen radij Zemlje. 
Topovska krogla ima maso 10.60 kg. Prečna površina krogle v smeri padanja je 0.01 m^2. 
Koeficient zračnega upora naj bo 0.28. 
Gostota zraka se spreminja v odvisnosti od višine glede na spodnjo tabelo (enako kot v domači nalogi)

[višina [m]  0  2000  4000  6000  8000  10000  15000  20000  25000  30000  40000]
[gostota [kg/m^3]  1.225  1.007  0.8194  0.6601  0.5258  0.4135  0.1948  0.08891  0.04008  0.01841  0.003996]

Podatke aproksimirajte s polinomom
ρ(h) = a_0 + a_2*((h − 40000)/40000)^2 + a_4*((h − 40000)/40000)^4
po metodi najmanjših kvadratov (določite parametre a_0, a_2 in a_4).

Pri vsakem vprašanju rešite diferencialno enačbo z vgrajeno metodo ode23s, 
ki se jo kliče in deluje enako ode45. Da bo možnost razlike v numeričnih 
odgovorih manjša, pri vsaki nalogi poiščite diskretno rešitev na izbranem 
časovnem intervalu, sestavljenem iz 10000 enakomerno razporejenih točk, 
vključno z začetno in končno točko.
%}


g_0 = 9.81;

visine = [0 : 2000 : 10000, 15000 : 5000 : 30000, 40000];
gostote = [1.225 1.007 0.8194 0.6601 0.5258 0.4135 0.1948 0.08891 0.04008 0.01841 0.003996];

ro_z = gostota_zraka(visine, gostote);

c_u = 0.28;  % koeficient zračnega upora
S = 0.01;  % prečna površina krogle
m = 10.6;  % masa

r = 6371 * 1000;
g = @(y) g_0 .* (r./(r + y)).^2;


% 1)
%{
Kroglo na višini 0 m izstrelimo iz topa navpično navzgor s hitrostjo 200 m/s. 
Kolikšna je predznačena hitrost krogle po 15 s?
%}

visina_tal = 0;
zac_hitrost = 200;
[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, 15, visina_tal, zac_hitrost, @ode23s);

y_(end)


% 2)
%{
Kroglo s Triglava na višini 2864 m izstrelimo iz topa navpično navzgor s hitrostjo 200 m/s. 
Po koliko sekundah krogla pade na tarčo ob Kredarici, ki je na višini 2515 m?
%}
triglav = 2864;
f = @(t_K) feliks(g, ro_z, c_u, S, m, 10000, t_K, triglav, zac_hitrost, @ode23s, false, false, true);

kredarica = 2515;
cas = fzero(@(t) f(t) - kredarica, 100);
cas


% 3)
%{
Kroglo z balona na višini 10000 m izstrelimo iz topa navpično navzgor s hitrostjo v. 
Določite v, da bo najvišja dosežena točka krogle ravno na 11000 m. 
Da bo možnost odstopanja rezultatov manjša, se dogovorimo, da je čas simulacije vedno 30 s.
%}

t_K = 30;
balon = 10000;
ff = @(v) max(feliks(g, ro_z, c_u, S, m, 10000, t_K, balon, v, @ode23s));

vrh_trajektorije = 11000;

hitrost = fzero(@(v) ff(v) - vrh_trajektorije, 50);
hitrost
