c = @(t) [-cos(t) + 2*cos(t/2); -sin(t) + 2*sin(t/2)];


% 1)
nal(1)
fprintf("Oddaljenost: %f \n", norm(c(1)))


% 2)
nal(2)
% ds = sqrt(dx^2 + dy^2) = sqrt(x'^2 + y'^2)dt
% dx = x'dt
% dy = y'dt
% x'(t) = sin(t) - sin(t/2)
% y'(t) = -cos(t) + cos(t/2)

% odvod c-ja:
odvod = @(t) [sin(t) - sin(t/2); -cos(t) + cos(t/2)];

% domena: [0, 4pi]
d = @(t) vecnorm(odvod(t));  % če bi uporabili norm, potem bi bil problem, saj
% funkcija 'integral' v funkcijo vnaša sezname, ne posamezne vrednosti

fprintf("Dolžina krivulje: %f \n", integral(d, 0, 4*pi));
% opomba: funkcija 'integral' bo klicala funkcijo z vektorjem vrednosti


% 3)
nal(3)

global prvi_clen
prvi_clen = @(x) x(1, :);  % če vstavljamo matriko, vrne prvo vrstico
drugi_clen = @(x) x(2, :);

x = @(t) prvi_clen(c(t));
y = @(t) drugi_clen(c(t));

x_odvod = @(t) prvi_clen(odvod(t));
y_odvod = @(t) drugi_clen(odvod(t));

integrand = @(t) x(t).*y_odvod(t) - y(t).*x_odvod(t);
ploscina_pod_zanko = integral(integrand, ...
    0, 4*pi) / 2;

fprintf("Ploščina zanke: %f \n", ploscina_pod_zanko);


% 4)
nal(4)
drugi_odvod = @(t) [cos(t) - cos(t/2)/2; sin(t) - sin(t/2)/2];

x_drugi_odvod = @(t) prvi_clen(drugi_odvod(t));
y_drugi_odvod = @(t) drugi_clen(drugi_odvod(t));

ukrivljenost = @(t) (x_odvod(t).*y_drugi_odvod(t) - y_odvod(t).*x_drugi_odvod(t))/(x_odvod(t).^2 + y_odvod(t).^2).^(3/2);

fprintf("Ukrivljenost: %f \n", ukrivljenost(2*pi));

% planaren_vekt_prod = @(x, y) prvi_clen(cross([0; x], [0; y]));  % ta je le za vektorje, ne pa za arraye vektorjev
% ta pa je za arraye vektorjev:
global planaren_vekt_prod
planaren_vekt_prod = @(x, y) prvi_clen(cross([zeros(1, length(x'*x)); x], [zeros(1, length(y'*y)); y]));
% length(x'*x) ti da širino matrike

ukrivljenost = @(t) planaren_vekt_prod(odvod(t), drugi_odvod(t))/norm(odvod(t))^3;

fprintf("Ukrivljenost (z vektorskim produktom): %f \n", ukrivljenost(2*pi));


% 5)
nal(5)
razdalja = @(t) sum(c(t));

% to ne deluje, saj predznak na koncih ni različen:
% nicla = fzero(razdalja, [0, 4*pi])

% opazimo, da za 2*pi predznak nasproten od obeh krajišč intervala
nicla1 = fzero(razdalja, [0, 2*pi]);
nicla2 = fzero(razdalja, [2*pi, 4*pi]);

presecisce1 = c(nicla1);
presecisce2 = c(nicla2);

fprintf("Prvo presečišče: [%s] \n", join(string(presecisce1), ', '))
fprintf("Drugo presečišče: [%s] \n", join(string(presecisce2), ', '))


% 6)
nal(6)

c_2 = @(t) (t/4).*[cos(t); sin(t)];
%{

nov_arctan = @(t) pi/2 - atan(1./t);  % malo modificiran, da je zaloga v [0, pi]

kot = @(t) nov_arctan(drugi_clen(c(t))/prvi_clen(c(t)));

seznam = @(t) [c_2(kot(t)), c_2(kot(t) + pi), c_2(kot(t) + 2*pi), c_2(kot(t) + 3*pi)];

razdalja = @(t) min(vecnorm(c(t).*ones(1, 4) - seznam(t)));

% ni v redu

%}
F = @(t) c(t) - c_2(t)
% fsolve(F)


% 7)
nal(7)

nicla1 = fzero(y_odvod, [0.0000001, 2*pi]);
nicla2 = fzero(y_odvod, [2*pi, 4*pi - 0.0000001]);

fprintf("Prva vrednost: %f \n", nicla1)
fprintf("Druga vrednost: %f \n", nicla2)


% 8) fminbnd  (analogno fzero)
nal(8)

% https://www.mathworks.com/matlabcentral/answers/38732-getting-first-element-of-a-function-output
pridobi_element = @ (matrika, vrstica, stolpec) subsref(matrika, struct('type','()','subs', {{vrstica, stolpec}}));

A = [2; 2];  % naša točka
razd = @(t) sqrt((A(1) - pridobi_element(c(t), 1, 1))^2 + (A(2) - pridobi_element(c(t), 2, 1))^2);

t_min_razdalja = fminbnd(razd, 0, 4*pi);
fprintf("Najmanjša razdalja do točke A(2, 2) je %f. \n", razd(t_min_razdalja))
% lahko pa tut tk, da iščemo, kdaj velja <F^.(t), A - F(t)> = 0


% 9) fminsearch  (analogno fsolve)
nal(9)

% funkcija_c = @(alfa) @(t) [alfa.*cos(t) + 2.*cos(0.5.*t); alfa.*sin(t) + 2.*sin(0.5.*t)];

global odvod_c_9_nal
global drugi_odvod_c_9_nal
odvod_c_9_nal = @(alfa) @(t) [-alfa.*sin(t) - sin(0.5.*t); alfa.*cos(t) + cos(0.5.*t)];
drugi_odvod_c_9_nal = @(alfa) @(t) [-alfa.*cos(t) - 0.5.*cos(0.5.*t); -alfa.*sin(t) - 0.5.*sin(t)];

%{
Vsakič ko inicializiramo nek nov global variable, se izpiše tole:
Warning: The value of local variables may have been changed to match the globals.  Future versions of
MATLAB will require that you declare a variable to be global before you use that variable. 
%}

integralj = @(alfa) integral(druzina(alfa), 0, 4*pi);
integralj(-1/2);

dolzina = @(alfa) integral(locni_element(alfa), 0, 4*pi);

funkcional = @(alfa) integralj(alfa) + dolzina(alfa);

alfa = fminsearch(funkcional, -1/2);
fprintf("Optimalen alfa je: %f \n", alfa)


% risanje:

t = linspace(0, 4*pi);
krivulja1 = c(t);
t2 = linspace(0, 3*pi);
krivulja2 = c_2(t2);

plot(krivulja1(1, :), krivulja1(2, :), 'color', [1 0 0])
hold on
plot(krivulja2(1, :), krivulja2(2, :), 'color', [0 1 0])

tocka = c(t_min_razdalja);
x = tocka(1);
y = tocka(2);
plot(x, y, 'o');  % najbližja točka točki A(2, 2)
plot(2, 2, 'o');  % točka A(2, 2)

% daspect([1 1 1])
axis equal  % naredi isto kot daspect, ampak bolje


function [rez] = locni_element(alfa)
    global odvod_c_9_nal
    o = odvod_c_9_nal(alfa);
    rez = @(t) vecnorm(o(t));
end

function [rez] = ukrivljenost2(alfa, odvod_c_9_nal, drugi_odvod_c_9_nal)
    % global prvi_clen, planaren_vekt_prod
    prvi_clen = @(x) x(1, :);  % če vstavljamo matriko, vrne prvo vrstico
    planaren_vekt_prod = @(x, y) prvi_clen(cross([zeros(1, length(x)); x], [zeros(1, length(y)); y]));

    o = odvod_c_9_nal(alfa);
    d = drugi_odvod_c_9_nal(alfa);
    rez = @(t) planaren_vekt_prod(o(t), d(t))./norm(o(t)).^3;
end

function [rez] = druzina(alfa)
    global odvod_c_9_nal
    global drugi_odvod_c_9_nal
    u = ukrivljenost2(alfa, odvod_c_9_nal, drugi_odvod_c_9_nal);
    o = odvod_c_9_nal(alfa);
    rez = @(t) u(t).^2 .* norm(o(t));
end

function [] = nal(n)
    fprintf("\nNaloga %u: \n", n)
end