addpath(genpath('..\..'))

%{
Dani sta fiksni točki A = (0.5, 1), B = (3.5, 0.5) in vektor zaporednih dolžin 
palic L = (1, 1, 2, 1, 1.5, 1) od leve proti desni. Vse palice so narejene iz 
enake jeklene homogene zmesi. Iščemo diskretno verižnico za levo krajišče A, 
desno krajišče B, sestavljeno iz palic z dolžinami L. Vprašanja so neodvisna, 
če ni posebej poudarjeno, in jih lahko rešujete v poljubnem vrstnem redu.
%}

A = [0.5; 1];
B = [3.5; 0.5];
L = [1, 1, 2, 1, 1.5, 1];
M = L;  % snov je homogena


% 1)
%{
Kolikšna je vsota koordinat najnižje točke na diskretni verižnici?
%}

voz = risi_veriznica([A B], L, M, true);
[~, i] = min(voz(2, :));
voz(1, i) + voz(2, i)  % -0.498513235387987


% 2)
%{
Zadnjo palico zamenjamo z novo, ki je ponovno iz enake homogene zmesi. 
Kolikšna naj bo dolžina palice, da bo četrta palica vzporedna z abscisno osjo? 
%}

dolz = @(l) dolzina(l, A, B, L, M);
x = fzero(dolz, 1)  % 2.012145007067402


% 3)
%{
Denimo, da v okolici diskretne verižnice položimo dolg raven magnetni trak. 
Zaradi ustvarjenega magnetnega polja, ki enakomerno vleče vse točke verižnice 
v smeri vektorja (−1, −1) proti traku, se oblika verižnice spremeni. Kolikšna 
je sedaj najnižja točka verižnice? Zaradi močnega magnetnega polja zanemarimo 
vpliv sile teže na verižnico.
%}
A_ = zasuci(A(1), A(2), pi/4);  % ni važno, okoli katere točke sukamo
B_ = zasuci(B(1), B(2), pi/4);
vozlisca = risi_veriznica([A_ B_], L, M);
nova_vozlisca = [];
for v = vozlisca
    nova_vozlisca(:, end + 1) = zasuci(v(1), v(2), -pi/4);
end
m = min(nova_vozlisca(2, :))  % -1.766276288843753

hold on
plot(nova_vozlisca(1, 1), nova_vozlisca(2, 1), 'o', 'color', 'blue');
for v = nova_vozlisca(:, 2:end - 1)
    plot(v(1), v(2), 'o', 'color', 'red');
end
plot(nova_vozlisca(1, end), nova_vozlisca(2, end), 'o', 'color', 'blue');

for i = 1 : size(nova_vozlisca, 2) - 1
    line(nova_vozlisca(1, i:i+1), nova_vozlisca(2, i:i+1), 'color', 'green');
end

% 4)
%{
Palice zamenjamo s tanko upogljivo vrvjo, ki je enake dolžine kot je vsota 
palic in je vpeta v A in B. Izračunajte absciso težišča vrvi.
%}

l = sum(L);
x = zvVer_tezisce(A, B, l)  % 1.938000937903018


% 5)
%{
Naj bo g = 9.81 gravitacijski pospešek. Pri točki A spustimo lahko kroglico, 
ki se odkotali do točke B po vrvi iz vprašanja 4). Določite vektor hitrosti 
kroglice, ko kroglica prvič doseže ravno polovico maksimalne hitrosti. 
Koliko je abscisa iskanega vektorja?
%}

[T_min, ~, w_] = zvVeriznica(A, B, l);

[~, hitrost] = zvVeriznica_cas_in_hitrost(A, B, l);
max_hitrost = hitrost(T_min(1));  % največja hitrost bo v najnižji točki

abscisa = inverz(hitrost, [A(1); T_min(1)], max_hitrost/2);  % abscisa_polovice_hitrosti

hitrost(abscisa)/sqrt(1 + w_(abscisa)^2)  % 0.761663614183896


function d = dolzina(l, A, B, L, M)  % za drugo nalogo
    voz = risi_veriznica([A B], [L(1:end - 1), l], [M(1:end - 1), l]);
    d = voz(2, 4) - voz(2, 5);
end
    
