addpath(genpath('..'))

%{
Predpostavimo, da je gravitacijski pospešek g konstantno enak 9.81. 
Določite brahistohrono k med točkama T0 = [1.00;5.85]⊤ in T1 = [6.25;3.50]⊤. 
Začetna hitrost kroglice je 0, trenja na krivulji ni.
%}

g = 9.81;

T0 = [1, 5.85];
T1 = [6.25, 3.5];


% 1)
%{
Izračunajte, za kolikokrat je čas potovanja kroglice po k hitrejši od časa potovanja po premici med T0 in T1. 
%}

% T0 = [0, 0]
% T1 = aT1 - aT0
b = T1(1) - T0(1);
B = T1(2) - T0(2);

cas_potovanja_po_premici(T0, T1)/cas_potovanja_po_brahistohroni(T0, T1)  % 1.289473052675614


% 2)
%{
Izračunajte dolžino krivulje k.
%}

dolzina_loka(T0, T1)  % 6.346204533773275


% 3)
%{
Kolikšen je čas potovanja kroglice od T0 do najnižje točke krivulje k?
%}

[k, theta_zvezdica, x, y, ~, ~, y_od_x, y_po_x, y_po_x_od_thete] = brah(T0, T1);
% theta_0 = min(theta_zvezdica, pi);
[x0, theta_0] = najnizja_tocka(T0, T1);

% rešitev:
T = k/sqrt(2*g) * theta_0  % 1.125798294535999


% alternativno, a malo manj natančno:
integrand = @(x) sqrt((1 + y_po_x(x).^2)./(-2*g*(-T0(2) + y_od_x(x))));
T = integral(integrand, T0(1), x0)  % 1.125796995987947


% 4)
%{
Naj kroglica prepotuje pot po brahistohroni, nato pa od T1 naprej nadaljuje pot v smeri poševnega meta. 
Določite absciso, kjer točka pade na tla (tj., y-komponenta kroglice je enaka 0).
%}

v_k = sqrt(-2*g*B);
odvod_k = y_po_x_od_thete(theta_zvezdica);
tang = v_k*[1, odvod_k]/norm([odvod_k; 1]);  % tangentni vektor ko kroglica pride do konca brahistohrone

% aT1(2) je y koordinata desnega konca brahistohrone
y_od_t = @(t) T1(2) + ((-t*g + tang(2)).^2 - tang(2).^2)./(-2*g);  % čas padanja pretvori v y koordinato


vrni_t = @(x) (x - T1(1))./tang(1);  % x koordinato pretvori v čas (samo, če x koordinata desno od desnega krajišča brahistohrone)

x_v_y = @(x) y_od_t(vrni_t(x));

fzero(x_v_y, [b, b + 10])  % 13.090714118420458

risi_brah(T0, T1)
hold on

narisi_crto(T1, T1 + tang)


% 5)
%{
Določite potencialno polje ΔU = ΔU(y), da bo posplošena brahistohrona ravno krivulja x^2 + y^3 = R. 
Naj velja R = 8.90 in ΔU(−0.5) = −0.05. Koliko je ΔU(−1)?
%}

R = 8.9;

% najprej poiščemo y':
% implicitno odvajamo x^2 + y^3 = R
% 2xdx + 3y^2y'dx = 0
% dy = y'dx
% dy/dx = -2x/3y^2

y_ = @(y) -2*sqrt(R - y^3)/(3 * y^2);

A = pridobi_A(y_, -0.5, -0.05);

delta_U = @(y) -A/(y_(y)^2 + 1);

delta_U(-1)  % -0.603497942386831
function A = pridobi_A(y_, y, delta_U_v_y)
    % delta_U_v_y je pač delta_U(y) 
    A = -delta_U_v_y * (y_(y)^2 + 1);
end

