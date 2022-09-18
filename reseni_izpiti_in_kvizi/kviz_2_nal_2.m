addpath(genpath('..'))

%{
V ravnini imamo podano Bezierjevo krivuljo b, b : [0,1] → R^2, katere kontrolne točke so opisane z naslednjo tabelo
 bC = b = [0.00 1.00 2.00 3.10 4.00 2.09 3.00; 0.00 2.00 -0.97 -1.00 3.04 2.00 1.00]; 

Prva vrstica predstavlja x-komponente, druga pa y-komponente kontrolnih točk.
Nasvet: če boste uporabljali metode fsolve, fminbnd, fminsearch ipd., 
uporabite nastavitev optimset('TolFun',1e-16), da bodo izračuni kar se da natančni.
%}

b = [0.00 1.00 2.00 3.10 4.00 2.09 3.00; 0.00 2.00 -0.97 -1.00 3.04 2.00 1.00]; 

options = optimset('TolFun',1e-16);


% 1)
%{
Izračunajte velikost odvoda krivulje b v levem krajišču.
%}

norm(bezier_der(b, 0))  % 13.416407864998739


% 2)
%{
Krivuljo b pri samopresečišču razdelimo na 2 manjši Bezierjevi krivulji, 
ki jih označimo zaporedoma z b1, b2. Krivulja b1 poteka od začetka 
originalne krivulje do (prvega) samopresečišča, b2 pa zavzema preostali del. 
Izračunajte povprečno vrednost y-komponent kontrolnih točk od b2.
%}

razd = @(x) norm(deCasteljau(b, x(1)) - deCasteljau(b, x(2)));
X = fminsearch(razd, [0.2; 0.8], options);


[~, b2] = sub_demo(b, X(1), false);
sum(b2(2, :))/size(b2, 2)  % 1.460441987157689


% 3)
%{
Krivuljo b2 s premikom zadnje kontrolne točke popravite tako, 
da je konec krivulje ravno v samopresečišču. 
Kolikšen notranji kot oklepa b2 v samopresečišču?
%}

v = -b2(:, end) + deCasteljau(b, X(1));
nov_b2 = premakni_Bezier(b2, [zeros(2, 6), v]);
od1 = bezier_der(nov_b2, 0);
od2 = bezier_der(nov_b2, 1);

kot = pi - acos(od1'*od2/(norm(od1)*norm(od2)))  % 0.989598390368879


% 4)
%{
Izračunajte največjo nepredznačeno ukrivljenost krivulje b.
%}


f = @(t) predznacena_ukrivljenost(b, t);

% figure
% t = linspace(0, 1)
% plot(t, f(t'))

x = fminbnd(@(s) -f(s), 0.5, 1);
f(x)  % 20.809867501939475


% 5)
%{
Denimo, da je krivulja b na levem robu vpeta v točki (0,0). 
Krivuljo spustimo, da se preko rotacije dotakne vodoravnih tal y=0. 
Določite preostalo točko, ki se dotika tal. Koliko je njena abscisa?
%}

figure
plotBezier(b)

kot = @(t) atan(vrni_koef(b, t));
t = fminbnd(kot, 0, 1);
najmanjsi_kot = kot(t);
tocka = deCasteljau(b, t);
tocka(1)  % 2.197645197423140

function k = vrni_koef(b, t)
    vektor = deCasteljau(b, t);
    k = vektor(2)/vektor(1);
end