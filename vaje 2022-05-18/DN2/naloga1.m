addpath '..\..\vaje 2022-04-06'
addpath '..\..'

%{
Predpostavimo, da je gravitacijski pospešek g konstantno enak 9.81. Določite brahistohrono k med točkama T0=[1,5]⊤ in T1=[6,2]⊤. Začetna hitrost kroglice je 0, trenja na krivulji ni.
%}

T0 = [1; 5];
T1 = [6; 2];

g = 9.81;

% 1)
%{
Kolikšen je čas potovanja kroglice od T0 do T1 po krivulji k?
%}

nal(1, cas_potovanja_po_brahistohroni(T0, T1))  % pride 1.265934630996953


% 2)
%{
Izračunajte čas potovanja kroglice po odsekoma linearni krivulji, ki poteka skozi točke T0, [3,2]⊤ in T1.
%}

% ko lomljenka spremeni naklon, se hitrost kroglice ohranja
% (to v praksi ni čisto res, ampak taka je predpostavka)

T_0_5 = [3; 2];

[t1, koncna_hitrost_1] = cas_potovanja_po_premici(T0, T_0_5);
t2 = cas_potovanja_po_premici(T_0_5, T1, koncna_hitrost_1);

nal(2, t1 + t2)  % pride 1.330952354898036


% 3)
%{
Kolikšna je največja hitrost kroglice na krivulji k?
%}

% zanima nas hitrost v najnižji točki brahistohrone

[~, theta_0, y0] = najnizja_tocka(T0, T1);

najnizja_ordinata = y0;
razlika_visine = y0 - T0(2);
v = sqrt(-2*g*razlika_visine);
% namreč, velja v = sqrt(-2*g*y(x))
nal(3, v)  % pride 7.680219032262394


% alternativno:
%{
[~, ~, x, ~, ~, ~, y_od_x, y_po_x] = brah(T0, T1);
% y_po_x(x(theta_0)) to bo blizu 0, ker tangenta vodoravna
v = sqrt(-2*g*y_od_x(x(theta_0)))
%}


% 4)
%{
Določite brahistohrono, ki ima krajišči T0 in T2 (ki je desno od T1) ter se s k ujema med točkama T0 in T1. Določite točko T2, da je čas potovanja kroglice od T0 do T2 ravno 1.5. Koliko je  ∥T2∥_2?
%}

[k, ~, x, y] = brah(T0, T1);

cas = @(t) cas_potovanja_po_brahistohroni(T0, [x(t); y(t)]) - 1.5;

t = fzero(cas, pi);
assert(t >= 0, "Čas mora biti nenegativen")

T2 = [x(t); y(t)];
plot(T2(1), T2(2), 'o')
nal(4, norm(T2))  % pride 8.063702792738658


% 5)
%{
Določite potencialno polje ΔU=ΔU(y), da bo posplošena brahistohrona ravno krivulja x3+y3=R. Naj velja R=8 in ΔU(−1)=−0.062602467658770. Koliko je ΔU(−2)?
%}
clear
R = 8;

% ΔU(y) bo vedno <= 0

% v = sqrt((2/m)*(-delta_U))

% najprej poiščemo y':
% implicitno odvajamo x^3 + y^3 = R
% 3x^2dx + 3y^2y'dx = 0
% dy = y'dx
% dy/dx = -x^2/y^2

% ampak prav je:
% y' = -1/(R - x^3)^(2/3)*x^2
% torej 

y_ = @(y) -na_2_3(R - y^3)/y^2;

% a = @(x) - x^2/na_2_3(R - x^3);
% y_ = @(y) a(na_1_3(R - y^3));

% no, izkaže se, da sta obe dve definiciji y' enakovredni

% velja: delta_U(y) = -A/(y_^2 + 1), za nek A > 0

A = pridobi_A(y_, -1, -0.062602467658770);
delta_U = @(y) -A/(y_(y)^2 + 1);

nal(5, delta_U(-2))  % -0.350745247939887


function A = pridobi_A(y_, y, delta_U_v_y)
    % delta_U_v_y je pač delta_U(y) 
    A = -delta_U_v_y * (y_(y)^2 + 1);
end

function rez = na_2_3(a)
    % a realno število
    % vrne a^(2/3), ampak brez da gre v kompleksna števila
    rez = (a^2)^(1/3);
end

function rez = na_1_3(a)
    % a realno število
    % vrne a^(1/3), ampak brez da gre v kompleksna števila
    rez = sign(a)*(a^2)^(1/6);
end


function nal(n, vrednost)
    fprintf("\nNaloga %u\n", n)
    fprintf("Rešitev: %.15f \n", vrednost)
end