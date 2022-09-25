addpath(genpath('..'))

%{
Feliks Vrtnar, svetovni znani padalec in adrenalinski zasvojenec, želi postaviti svetovni rekord v hitrosti v prostem padu. 
Feliks si je zadal skočiti iz balona z višine 40000 m nad tlemi. 
Pred skokom vas prosi, da opravite numerično simulacijo skoka, iz katerega bi bilo bolj jasno, 
če bi predviden skok izpolnil njegova visoka pričakovanja. 
Vzemite g_0 = 9.81 m/s^2 za pospešek na nadmorski višini 0. 
Pospešek se z višino spreminja po formuli g(h) = g_0 * (r/(r+h))^2, kjer je r = 6371 km povprečen radij Zemlje. 
Upoštevajte, da Feliks skupaj z obleko in vso opremo tehta 109.0 kg. 
Prečna površina padalca v smeri padanja je 1.3 m^2. 
Koeficient zračnega upora naj bo 1.2. 
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
c_u = 1.2;
S = 1.3;
m = 109;

r = 6371 * 1000;
g = @(y) g_0 .* (r./(r + y)).^2;


% 1)
%{
Izračunajte hitrost padalca po 30 s
%}

t_K = 30;
[~, y_] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode23s, true);
y_(end)  % -2.621151534555762e+02

% 2)
%{
Denimo, da bi padalec skočil v tandemu s svojim kolegom, ki ima enako maso kot Feliks. 
Problem modeliramo kot da je en težji padalec s podvojeno prečno površino, koeficient upora pa ostane enak. 
Izračunajte prepotovano pot po 100 s.
%}

t_K = 100;
[y, ~] = feliks(g, ro_z, c_u, 2*S, 2*m, 10000, t_K, 40000, 0, @ode23s, true);
40000 - y(end)  % 2.080186207437838e+04

% 3)
%{
Izračunajte skupen čas padanja padalca, od skoka do pristanka na tleh na nadmorski višini 500 m.
%}

f = @(t) feliks(g, ro_z, c_u, S, m, 10000, t, 40000, 0, @ode23s, false, false, true) - 500;
cas = fzero(f, 100)  % 4.318192666451984e+02

% 4)
%{
Za izvedbo skoka padalec potrebuje dovoljšnjo količino dodatnega zraka v rezervoarju. 
Maso slednjega zanemarimo. Ko je gostota zraka 0.5 kg/m^3 ali več, lahko 
padalec normalno diha okoliški zrak. Za koliko sekund zraka potrebuje padalec v rezervoarju?
%}
y_dihanja = inverz(ro_z, 20000, 0.5);
visina = @(t) feliks(g, ro_z, c_u, S, m, 10000, t, 40000, 0, @ode23s, false, false, true);
cas = inverz(visina, 200, y_dihanja)  % 2.445118707667337e+02

% 5)
%{
Po 300 s padanja padalec v trenutku odpre padalo. Na ta način se poveča prečna 
površina padalca za 8 m^2, koeficient zračnega upora pa se poveča za štirikrat. 
Izračunajte skupen čas padanja padalca, do pristanka na tleh na nadmorski višini 500 m.
%}


t_K = 300;
[visina_pri_odprtju, hitrost_pri_odprtju] = feliks(g, ro_z, c_u, S, m, 10000, t_K, 40000, 0, @ode23s, false, false, true);

f = @(t) feliks(g, ro_z, 4 * c_u, S + 8, m, 10000, t, visina_pri_odprtju, hitrost_pri_odprtju, @ode23s, false, false, true) - 500;

skupen_cas = t_K + fzero(f, 100)  % 1.006957310379624e+03
