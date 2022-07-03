% inverz(funkcija, priblizek_x, y_kjer_evalviramo)

% inverz(f, [0, 1])  % najde inverz na intervalu [0, 1] (tj. inverz zožitve)

% inverz(f, priblizek_x): če zaznamo, da f sprejema števila in vrača
% števila (tj., f: R -> R) in je približek tak, da ima kvečjemu dve vrstici
% (dve vrstici je, če vstavljamo interval kot pogoj), potem se kliče fzero,
% drugače fsolve
% če se izkaže, da f ni oblike R -> R, potem se kliče fsolve
% za y in priblizek_x velja, da vsak stolpec predstavlja nov poskus, tj.,
% inverz se evalvira v vsakem stolpcu posebej
% priblizek_x lahko ima ali enako število stolpcev kot y, ali pa ima le en
% stolpec (in je torej enak približek za vsak stolpcev od y)


f1 = @(t) tan(t);
g1 = inverz(f1, 0);
g1(1)
% alternativno: 
inverz(f1, [], 1)

% če podamo interval (interval mora biti podan v obliki stolpca, ne vrstice)
g1 = inverz(f1, [-1; 1]);
g1(1)


f2 = @(t) cos(t(1)) + sin(t(2));
g2 = inverz(f2, [-1; 2]);
g2(1)
