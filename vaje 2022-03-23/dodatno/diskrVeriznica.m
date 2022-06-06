function vozlisca = diskrVeriznica(w_0,obesisceL,obesisceD,L,M)
% function x = diskrVeriznica(w0,obesisceL,obesisceD,L,M)
% diskrVeriznica resi problem diskretne veriznice: preko fsolve najde u in v, tako da
% F(u,v) = [0; 0], nato veriznico narise.
% Po knjigi Matematicno modeliranje (E. Zakrajsek).
% vhod:
% w0 = [u0;v0] zacetna priblizka,
% obesisceL = [x_0;y_0],
% obesisceD = [x_(n+1);y_(n+1)],
% L = dolzine palic (vektor).
% M = mase palic (vektor).
%
% izhod:
% x je 2x(n+2) tabela koordinat vozlisc.

[x_0, y_0] = obesisceL;
[x_n_1, y_n_1] = obesisceD;  % [x_(n + 1); y_(n + 1)]
[u_0, v_0] = w_0;

pomozna_spr = (1/2)*([M, 0] + [0, M]);  % seznam dolžine n + 2
mi = pomozna_spr(2:end - 1);  % seznam dolžine n

rez = Newtonova_metoda(x_0, y_0, x_n_1, y_n_1, L, mi, u_0, v_0);

u = rez(1);
v = rez(2);

ni = [0, cumsum(mi, 2)];  % seznam dolžine n + 1
w = @(u, v) v - u * ni;  % seznam dolžine n + 1

ksi = L./sqrt(1 + w.^2);  % seznam dolžine n + 1
ni = ksi.*w;

x = x_0 + [0, cumsum(ksi, 2)];
y = y_0 + [0, cumsum(ni, 2)];
vozlisca = [x; y];




end
