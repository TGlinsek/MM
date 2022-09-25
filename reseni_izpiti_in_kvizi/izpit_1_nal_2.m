addpath(genpath('..'))

%{
Dani sta fiksni točki A = (0.02, 1.00), B = (3.50, 0.10) skozi katero napeljemo tanko upogljivo vrv dolžine 5.54.
%}

global A
global B
A = [0.02; 1.00];
B = [3.50; 0.10];

global l
l = 5.54;


% 1)
%{
Določite naklon vrvi v točki A.
%}

[tmin, w, w_] = zvVeriznica(A, B, l);
w_(A(1))


% 2)
%{
Denimo, da najnižjo točko vrvi navpično dvignemo na višino 0. 
Oblika vrvi se ustrezno spremeni. 
Določite novo najnižjo točko vrvi.
%}

d = @(x) dolzina_zvVer(A, B, l, x);
l1 = d(tmin(1));
l2 = l - l1;

novtmin = [tmin(1); 0];
tmin1 = zvVeriznica(A, novtmin, l1);
tmin2 = zvVeriznica(novtmin, B, l2);
min(tmin1(2), tmin2(2))


% 3)
%{
Poiščite točko na začetno vpeti vrvi, kjer velja naslednja lastnost. 
Če točko vrvi navpično dvignemo na višino 0, bo vrv imela natanko dve najnižji ordinati. 
Koliko je asbcisa iskane točke?
%}

nov_x = fzero(@(x) pomozna3(x), tmin(1));
nov_x


% 4)
%{
Vrv zamenjamo z n tankimi enakimi homogenimi palicami, 
tako da je vsota palic enaka dolžini vrvi. 
Palice povežemo med seboj z gibljivimi členki, prvo palico pričvrstimo v A, 
zadnjo v B. Koliko mora biti najmanjši n, da bo najnižja točka vseh palic 
od najnižje točke vrvi oddaljena za manj kot 2 ⋅ 10^−3?
%}

pomozna4 = @(n) pomozna2(n, tmin);

for i = 2 : 100
    s = pomozna4(i);
    if s < 2*0.001
        break
    end
end
i


function raz = pomozna2(n, tmin)  % za 2. nalogo
    global A
    global B
    global l

    dolzina = l/n;
    
    voz = risi_veriznica([A, B], dolzina*ones(1, n), ones(1, n), true);
    [~, v] = min(voz(2, :));
    raz = norm(voz(:, v) - tmin);
end

function razlika = pomozna3(x)  % za 3. nalogo
    global A
    global B
    global l
    
    d = @(x) dolzina_zvVer(A, B, l, x);
    l1 = d(x);
    l2 = l - l1;

    novtmin = [x;0];
    tmin1 = zvVeriznica(A, novtmin, l1);
    tmin2 = zvVeriznica(novtmin, B, l2);
    razlika = tmin1(2) - tmin2(2);
end