addpath(genpath('..'))

%{
S kubično Bezierjevo krivuljo b, b : [0, 1] → R^2, bi radi aproksimirali 
krožni lok enotske krožnice s središčem v (0, 0). Bezierjeva krivulja naj v 
krajiščih zaporedno interpolira točki A = (cos(0.14), sin(0.14)) in 
B = (cos(1.60), sin(1.60)).
%}


% 1)
%{
Kontrolno točko b_1 dobite tako, da se iz b_0 za polovico enote premaknete 
navpično navzgor. Kontrolno točko b_2 dobite tako, da se iz b3 za polovico 
enote premaknete v desno. Koliko je ∥b(1/2)∥_2?
%}

% b1 in b2 dobimo iz izhodišč, ki sta v A oz. B

fi1 = 0.14;
fi2 = 1.6;
A = [cos(fi1); sin(fi1)];
B = [cos(fi2); sin(fi2)];

b1 = A + [0; 0.5];
b2 = B + [0.5; 0];
b = [A b1 b2 B];
norm(deCasteljau(b, 0.5))


% 2)
%{
Denimo, da delec potuje po krivulji b iz (a) z enakomerno hitrostjo od b(0) do b(1). 
Določite parameter t ∈ [0, 1] za točko b(t), pri katerem delec prepotuje 
ravno 1/3 celotne poti.
%}

% naravni parameter dobimo kot inverz funkcije, ki meri dolžino
% dolžino izmerimo z integralom ločnega elementa

prvi = @(A) A(1, :);
drugi = @(A) A(2, :);

odvod_f = @(t) odvod_Bez(b, 1, t');
locni_el = @(t) sqrt(prvi(odvod_f(t)).^2 + drugi(odvod_f(t)).^2);


d = @(t) integral(@(t_) locni_el(t_), 0, t);
dolz = d(1);
inverz(d, 0.5, dolz/3)


% 3)
%{
Notranji kontrolni točki b_1, b_2 popravite tako, da se tangentna vektorja 
Bezierjeve krivulje v krajiščih po smeri ujemata s tangentnima vektorjama 
krožnice v točkah A, B in da sta med seboj enakih dolžin. 
Hkrati naj velja, da b pri parametru 1/2 interpolira točko na krožnici. 
Koliko je ∥b(1/4)∥_2 − 1?
%}

% datoteka aproksimacija_kroznice zna rešiti le primer, ko fi1 = -fi2
% zato bomo najprej zarotirali krivuljo tako, da sta si kota med
% izhodiščema ravno nasprotna, nato uporabili funkcijo, nato pa zarotirali
% nazaj

fi = (fi2 - fi1)/2;
r = 1;

b = aproksimacija_kroznice(r, fi, false);
b_zarotiran = rotiraj_bezier(b, -(fi1 + fi2)/2);

norm(deCasteljau(b_zarotiran, 1/4)) - 1
