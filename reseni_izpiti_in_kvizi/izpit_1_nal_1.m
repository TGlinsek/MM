addpath(genpath('..'))

%{
Oblika radialno simetrične membrane je opisana s funkcijo u, v odvisnosti od radija r ∈ [0, 2.00]. 
Funkcija u zadošča diferencialni enačbi
u′′(r) + (1/r)*u′(r) = c − r,
kjer je u′(0) = 0 in u(2.00) = d. 
Približek za u poiščemo z metodo končnih diferenc (MKD). 
Domeno [0, 2.00] razdelimo na n enako velikih intervalov 
in na dobljeni mreži poiščemo približek za u v točkah u_i := u(r_i) za i = 0, 1, ..., n.
%}


% 1)
%{
Naj bo n = 20, c = 2.01 in d = 0. Kolikšen je numeričen približek za u(0) preko MKD?
%}

d = 0;
n = 20;
c = 2.01;
f = @(r) c - r;
u = upogib_opne(f, 2, n);
u(1) + d


% 2)
%{
Naj bo n = 40, c = 2.01 in d = 3.00. Koliko je numerični približek za u(1)?
%}

d = 3;
n = 40;
c = 2.01;
f = @(r) c - r;
u = upogib_opne(f, 2, n);
u(21) + d  % 21 je ravno na polovici
