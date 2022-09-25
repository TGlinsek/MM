addpath(genpath('..'))

%{
Dani sta fiksni točki A = (0.00, 1.00), B = (3.50, 0.00) skozi katero napeljemo tanko upogljivo vrv dolžine 5.50.
%}

A = [0; 1];
B = [3.5; 0];
l = 5.5;


% 1)
%{
Določite brezdimenzijsko potencialno energijo vrvi, ∫_A1^B1 w(x)*sqrt(1+w′(x)^2) dx, kjer je y = w(x).
%}

[~, w, w_] = zvVeriznica(A, B, l);
integrand = @(x) w(x).*sqrt(1 + w_(x).^2);
brezdim_potenc_en = integral(integrand, A(1), B(1))
% brezdimenzijska potencialna energija je ravno potencialna energija,
% deljena z g in z maso verižnice

% alternativno:
% [~, W_y] = zvVer_tezisce(A, B, l);
% brezdim_potenc_en = W_y * l;
% Torej, potencialno energijo moramo množiti z dolžino vrvi.
% Nekaj podobnega bomo storili pri 4. podnalogi te naloge.


% 2)
%{
Določite novo točko B tako, da bo najnižja točka vrvi ravno (2,-1). 
Kolikšna je razdalja točke B do izhodišča?
%}

f = @(x) najnizja(A, [x(1); x(2)], l) - [2; -1];
norm(fsolve(f, B))


% 3)
%{
Za začetni točki A, B določite dolžino vrvi tako, da bo čas potovanja kroglice od A, B z začetno hitrostjo 0 ravno 1.5 časovne enote. 
Naj bo g = 9.81 gravitacijski pospešek.
%}

h = @(l) cas(A, B, l);
fzero(@(t) h(t) - 1.5, [5, 10])


% 4)
%{
Vrv (začetne dolžine) zamenjamo z n tankimi enakimi homogenimi palicami tako, 
da je vsota dolžin palic enaka dolžini vrvi in vsota mas palic enaka masi vrvi. 
Palice povežemo med seboj z gibljivimi členki, prvo palico pričvrstimo v A, 
zadnjo v B (iz začetnega navodila). Določite najmanjši n, da se brezdimenzijska 
potencialna energija skupka palic (premislite, kako jo definirati, da bo 
diskretna verzija zgoraj definirane zvezne energije verižnice) razlikuje od 
brezdimenzijske potencialne energije vrvi za manj kot 10−2? Izpišite vrednost 
potencialne energije palic.
%}


n = 2;  % recimo, da začnemo pri prvem netrivialnem primeru
razlika = inf;
while razlika >= 0.01
        
    M = ones(1, n);  % mase nastavimo na 1, saj mora rezultat biti brezdimenzijski
    L = l/n * ones(1, n);
    voz = risi_veriznica([A B], L, M);
    [~, ty, p] = tezisce(voz, M);
    
    razlika = abs(ty*l - brezdim_potenc_en);
    n = n + 1;
end

ty*l

% ordinata težišča se dobi kot integral od y * ločni element,
% ampak ulomljeno z integralom ločnega elementa, torej dolžino
% zato moramo tu množiti z dolžino, da dobimo brezdimenzijsko količino


function C = najnizja(A, B, l)  % vrne najnižjo točko verižnice
    [~, w] = zvVeriznica(A, B, l);
    x = fminbnd(w, A(1), B(1));
    C = [x; w(x)];
end

function T = cas(A, B, l)  % čas se izračuna po spodnji formuli
    g = 9.81;
    [~, w, w_] = zvVeriznica(A, B, l);
    integrand = @(x) sqrt((1 + w_(x).^2)./(-2*g*(-A(2) + w(x))));

    T = integral(integrand, A(1), B(1));
end