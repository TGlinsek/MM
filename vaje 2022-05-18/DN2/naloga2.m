addpath '..\..'
addpath '..\..\vaje 2022-05-11'
addpath '..\..\vaje 2022-05-11\Bezierove krivulje 1'
addpath '..\..\vaje 2022-05-11\Bezierove krivulje 2'

%{
V ravnini imamo podano Bezierjevo krivuljo b, b:[0,1]→R^2, katere kontrolne točke so opisane z naslednjo tabelo
 bC = [0 1 2 3 4 2 1.5 1; 0 2 -1 1 3 2 1 0]. 
Prva vrstica predstavlja x-komponente, druga pa y-komponente kontrolnih točk.
Nasvet: če boste uporabljali metode fsolve, fminsearch ipd., uporabite nastavitev optimset('TolFun',1e-16), da bodo izračuni kar se da natančni.
%}

options = optimset('TolFun', 1e-16);


bC = [0 1 2 3 4 2 1.5 1; 0 2 -1 1 3 2 1 0];


% 1)
%{
Krivuljo bk dobite iz b tako, da krivuljo b ustrezno zavrtite in vzporedno premaknete, da velja b(0)=bk(1) in b(1)=bk(0). Kolikšna je vrednost ∥bk(1/3)∥_2?
%}

vektor = bC(:, end) - bC(:, 1);
rot = rotiraj_bezier(bC, pi);
b_k = premakni_Bezier(rot, vektor*ones(1, 8));
nal(1, norm(deCasteljau(b_k, 1/3)))
% 1.445629414537685


% 2)
%{
Krivuljo b pri samopresečišču razdelimo na 3 manjše Bezierjeve krivulje, ki jih označimo zaporedoma z b1,b2,b3. Določite vse 3 krivulje. Kolikšna je vrednost ∥b2(1/3)∥_2, če je b2 parametrizirana z lokalnim parametrom na intervalu [0,1]?
%}
razd = @(x) norm(deCasteljau(bC, x(1)) - deCasteljau(bC, x(2)));
X = fminsearch(razd, [0.3; 0.7], options);
t = 1/3;  % lokalni parameter
u = X(1) * (1 - t) + X(2) * t;  % globalni parameter
nal(2, norm(deCasteljau(bC, u)))
% 2.839051552530711


% 3)
%{
Kolikšna je x-komponenta težišča krivulje b?
%}

prvi = @(A) A(1, :);
drugi = @(A) A(2, :);

f = @(t) deCasteljau(bC, t');  % transponiramo, ker integral deluje tako, da poda seznam točk [t_1, t_2, ...]
% ampak deCasteljau je narejen tako, da so vrednosti po vrsticah, ne pa po
% stolpcih

odvod_f = @(t) odvod_Bez(bC, 1, t');

locni_el = @(t) sqrt(prvi(odvod_f(t)).^2 + drugi(odvod_f(t)).^2);

dolzina = integral(@(t) locni_el(t), 0, 1);
abscisa_tezisca = integral(@(t) prvi(f(t)).*locni_el(t), 0, 1)/dolzina;
nal(3, abscisa_tezisca)

% 1.567575569631437


% 4)
%{
Ordinato četrte kontrolne točke krivulje b določite tako, da bo dolžina krivulje b čim manjša. Kolikšna je dolžina optimalne krivulje b? (Nasvet: Pri iskanju minimuma si pomagajte z metodo fminsearch.)
%}

odvod_f = @(b, t) odvod_Bez(b, 1, t');

locni_el = @(b, t) sqrt(prvi(odvod_f(b, t)).^2 + drugi(odvod_f(b, t)).^2);
dolzina_krivulje = @(b) integral(@(t) locni_el(b, t), 0, 1);

zamik_kontrolne_tocke = @(y) [bC(:, 1:3), [bC(1, 4); y], bC(:, 5:end)];

komp = @(y) dolzina_krivulje(zamik_kontrolne_tocke(y));  % kompozitum

y = fminsearch(@(y) komp(y), bC(2, 4), options);
nal(4, komp(y))
% 6.079292157175657


% 5)
%{
Originalno krivuljo b reparametriziramo v naravnem parametru s. Novo krivuljo (ki ni Bezierjeva krivulja) označimo s c=c(s), ki ima enako tirnico kot b. Določite vektor c′′(3). Koliko je x-komponenta vektorja?
%}

odvod_f = @(t) odvod_Bez(bC, 1, t');
drugi_odvod_f = @(t) odvod_Bez(bC, 2, t');

locni_el = @(t) sqrt(prvi(odvod_f(t)).^2 + drugi(odvod_f(t)).^2);


d = @(t) integral(@(t_) locni_el(t_), 0, t);
% inverz_d = @(t) fzero(@(x) d(x) - t, 0);
inverz_d = inverz(d);

b_ = @(t) odvod_Bez(bC, 1, t);
b__ = @(t) odvod_Bez(bC, 2, t);

d_ = @(t) locni_el(t);
d__ = @(t) (prvi(odvod_f(t))*prvi(drugi_odvod_f(t)) + drugi(odvod_f(t))*drugi(drugi_odvod_f(t)))/d_(t);  % odvod ločnega elementa: ga izpeljemo analitično

% c(s) = b(d^-1(s))

% c'(s) = b'(d^-1(s))*(1/d'(d^-1(s)))

% c''(s) = b''(d^-1(s))*(1/d'(d^-1(s)))^2 - b'(d^-1(s))*(d''(d^-1(s))/(d'(d^-1(s)))^3)

% c'':
c__ = @(s) b__(inverz_d(s))*(1/d_(inverz_d(s)))^2 - b_(inverz_d(s))*d__(inverz_d(s))/d_(inverz_d(s))^3;

iskani_vektor = c__(3);
nal(5, iskani_vektor(1))
% -0.741923478455250


function nal(n, vrednost)
    fprintf("\nNaloga %u\n", n)
    fprintf("Rešitev: %.15f \n", vrednost)
end