addpath(genpath('..'))

%{
Predpostavimo, da je gravitacijski pospešek g konstantno enak 9.81. 
Določite brahistohrono k med točkama T0=[1.00;5.05]⊤ in T1=[6.60;3.50]⊤. 
Začetna hitrost kroglice, ki jo spustimo po k v točki T0, je enaka 0, 
trenje na krivulji zanemarimo.
%}

T0 = [1; 5.05];
T1 = [6.60;3.50];


% 1)
%{
Naj bo t∗ čas potovanja kroglice od T0 do T1 po k. 
Določite koordinate kroglice na krivulji k, ob času t∗/2. 
Koliko je 2-norma pripadajočega krajevnega vektorja?
%}

[~, theta_zvezdica, x, y, x_, y_] = brah(T0, T1);
x = x(theta_zvezdica/2);
y = y(theta_zvezdica/2);
norm([x; y])


% 2)
%{
Koliko bi morala biti abscisa točke T1, 
da bi bil čas potovanja kroglice od T0 do T1 ravno 2 s?
%}

cas = @(x) cas_potovanja_po_brahistohroni(T0, [x; T1(2)]);
inv = inverz(cas, 0);
inv(2)


% 3)
%{
Krivuljo k aproksimirajte z Bezierjevo krivuljo b:[0,1]→R2 tako, 
da velja b(0) = T0, b(1) = T1 in naj bo 2. kontrolna točka b1 enaka T0 − [0;1]. 
Naj bo γ:[0,θ∗] → [0,1], θ ↦ t linearna reparametrizacija krivulje b v 
parametru θ, torej dobimo funkcijo (b ∘ γ)(θ). Tretjo kontrolo točko določite 
tako, da bo veljalo k′(θ∗)=(b ∘ γ)′(θ∗), kjer smo s ′ označili odvod po θ. 
Koliko je ∥b(1/2)∥_2?
%}

k = [x_(theta_zvezdica);
    y_(theta_zvezdica)];

% (b kompozitum gamma)'(theta_zvezdica)
b0 = T0;
b3 = T1;
b1 = T0 - [0;1];
b2 = b3 - theta_zvezdica*k/3;

norm(deCasteljau([b0, b1, b2, b3], 0.5))


% 4)
%{
Določite čas potovanja kroglice po Bezierjevi krivulji iz 3).
%}

g = 9.81;

global b;
b = [b0, b1, b2, b3];

xt = @(t) xt1(t);  % x(t)
yt = @(t) yt1(t);  % y(t)
dxt = @(t) dxt1(t);  % dx/dt(t)
dyt = @(t) dyt1(t);  % dy/dt(t)


y_ = @(x) dyt(t_od_x(x)) * dt_od_x(x);  % dy/dx(x)
y = @(x) yt(t_od_x(x));  % y(x)

integrand = @(x) sqrt((1 + y_(x).^2)./(-2*g*(y(x) - y(xt(0)))));

integral(@(t) razbijalec(integrand, t), xt(0), xt(1))



function s = xt1(t)
    global b
    a = odvod_Bez(b, 0, t');
    s = a(1);
end

function s = yt1(t)
    global b
    a = odvod_Bez(b, 0, t');
    s = a(2);
end

function s = dxt1(t)
    global b
    a = odvod_Bez(b, 1, t');
    s = a(1);
end

function s = dyt1(t)
    global b
    a = odvod_Bez(b, 1, t');
    s = a(2);
end

function s = t_od_x(x)  % t(x)
    s = inverz(@(t) xt1(t), [0; 1], x);
end

function s = dt_od_x(x)  % dt/dx(x)
    s = 1./(dxt1(t_od_x(x)));
end