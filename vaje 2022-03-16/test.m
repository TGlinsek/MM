n = 32;
a = 1;
tol = 1e-3;

f_levo = @(x) zeros(size(x));
f_desno = @(x) 1 - x.^2;
f_zgoraj = @(x) 1 - x.^2;
f_spodaj = @(x) x.^2 - 1;

metoda = 'Jacobi';

milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, metoda);

f_spodaj = @(x) 1 - x.^2;
f_zgoraj = f_spodaj;
f_desno = f_zgoraj;
f_levo = f_desno;

milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, metoda);
