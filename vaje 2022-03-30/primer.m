% dva stebra višine 50 m
% dolina verige 80 m
% Koliko sta stebra narazen, če:
% a) T_min = 10 m
% b) T_min = 20 m

a = 0;  % BŠS
A = 50;
B = 50;
l = 80;

tol = 0.01;  % to lahko malo popravljamo

T_min = @(b) zvVeriznica([a; A], [b; B], l, tol);

max_razdalja_od_a_do_b = sqrt(l^2 - (B - A)^2);

% a)
% problem je, da je T_min večja od 10m za x > 0. Rešitev je namreč natanko
% x = 0

%{
f1 = @(x_) f(x_, 10, T_min);  % če se funkcija spusti do 10m
x = fzero(f1, [0.0001, max_razdalja_od_a_do_b]);
x
%}


% b)

f2 = @(x_) f(x_, 20, T_min);  % če se funkcija spusti do 10m
x = fzero(f2, [0.0001, max_razdalja_od_a_do_b]);
fprintf("Razdalja med a in b: %f\n", x);  % x koordinata, kjer T_min(x) minimalen
[y, ~] = T_min(x);
fprintf("Višina: %f\n", y(2));

function rezultat = f(x_, premik, T_min)
    [y_, ~] = T_min(x_);
    rezultat = y_(2) - premik;
end