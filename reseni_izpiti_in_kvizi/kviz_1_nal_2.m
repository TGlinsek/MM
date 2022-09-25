addpath(genpath('..'))

%{
Dani sta fiksni točki A = (0.0,1.0), B = (3.5,0.4) in vektor zaporednih dolžin 
palic L = (1.0, 1.0, 2.4, 0.5, 0.5, 1.0, 1.0, 1.0) od leve proti desni. Vse palice 
so narejene iz enake jeklene homogene zmesi. Iščemo diskretno verižnico za 
levo krajišče A, desno krajišče B, sestavljeno iz palic z dolžinami L. 
Vzemite g = 9.81 za gravitacijski pospešek in naj bo masa enaka m za palico 
dolžine m. Vprašanja so neodvisna, če ni posebej poudarjeno, in jih lahko 
rešujete v poljubnem vrstnem redu.
%}

A = [0; 1];
B = [3.5; 0.4];
L = [1, 1, 2.4, 0.5, 0.5, 1, 1, 1];
g = 9.81;
M = L;

% 1)
%{
Določite najnižjo ordinato verižnice
%}

vozlisca = risi_veriznica([A, B], L, M);
min(vozlisca(2, :))  % -2.965849444704330

% 2)
%{
Izračunajte potencialno energijo verižnice.
%}

[~, ~, pot_en] = tezisce(vozlisca, M)  % -1.032956095176899e+02

% 3)
%{
Določite obliko verižnice, kjer bi bila skupna potencialna energija največja. 
Koliko je najvišja ordinata verižnice?
%}

nova_vozlisca = risi_veriznica([A, B], L, -M);
max(nova_vozlisca(2, :))  % 4.239354630580824

% 4)
%{
Palice zamenjamo s tanko upogljivo vrvjo, ki je enake dolžine kot je vsota 
palic in je vpeta v A in B. Izračunajte potencialno energijo vrvi. 
Naj bo masa ene enote dolžine vrvi enaka ena.
%}

l = sum(L);
pot_ener_ce_masa_1 = zvVeriznica_pot_ener(A, B, l);
pot_ener = pot_ener_ce_masa_1 * l  % -1.048003425406915e+02
% zadnji stavek navodil v bistvu pomeni, da je vrv homogena

% 5)
%{
V točki B naj bo škripec, preko katere je napeljana vrv iz 4). 
Vrv preko škripca potegnemo vodoravno proti desni ravno za toliko, 
da je najnižja točka vrvi ravno na višini -1, in točko na vrvi, ki se 
dotika škripca, pobarvamo. Nato vrv spustimo nazaj v prvotno lego. 
Določite ordinato pobarvane točke vrvi. 
%}

tmin = @(l_) comp(zvVeriznica(A, B, l_), 2) + 1;  % comp(..., 2) vzame drugi element seznama
prava_dolzina = fzero(tmin, l);

[~, w, ~] = zvVeriznica(A, B, l);

abscisa_v_dolzino = @(x) dolzina_zvVer(A, B, l, x);
nas_x = inverz(abscisa_v_dolzino, B(2), prava_dolzina);  % B(2) je samo približek
w(nas_x)  % -2.594835533383483

% če fzero vrne
% Operands to the logical and (&&) and or (||) operators must be convertible to logical scalar values.
% potem to verjetno pomeni, da funkcija ne vrača števil, ampak matrike


% 6*)
%{
V točki med 4. in 5. palico diskretne verižnice obesimo majhno utež z maso 10. 
Določite najnižjo ordinato verižnice.
%}

L = [L(1:4), 0, L(5:end)];
M = [M(1:4), 10, M(5:end)];
voz = risi_veriznica([A, B], L, M);
min(voz(2, :))  % -3.006897472107350