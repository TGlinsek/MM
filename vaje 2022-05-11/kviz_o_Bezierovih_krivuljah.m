addpath 'Bezierove krivulje 1'
addpath 'Bezierove krivulje 2'

b = [[0; 0], [1; -1], [2; -1], [4; 2]];


% 1)
nal(1)
tocka = deCasteljau(b, 0.5);
fprintf("Abscisa točke: %.15f \n", tocka(1))
% 1.625


% 2)
nal(2)
prvi_odvod = odvod(b, 1, 0.5);

fprintf("Norma odvoda: %.15f \n", norm(prvi_odvod))
% 4.038873605350878


% 3)
nal(3)
fprintf("Razdalja do izhodišča: %.15f \n", norm(deCasteljau(b, 0.5)))
% 1.700183813591930


% 4)
nal(4)
drugi_odvod = odvod(b, 2, 0.5);

ukrivljenost = (prvi_odvod(1).*drugi_odvod(2) - prvi_odvod(2).*drugi_odvod(1))/(prvi_odvod(1).^2 + prvi_odvod(2).^2).^(3/2);
fprintf("Predznačena ukrivljenost: %.15f \n", ukrivljenost)
% 0.614715602241275


% 5)
nal(5)
[leve, desne] = sub_demo(b, 0.4, false);
vsota = sum(leve');
fprintf("Vsota ordinat je: %.15f \n", vsota(2))
% -1.632


% 6)
nal(6)
tocka = presek_s_premico(b, [[0;1], [1; -1]], 0.000001, false);
assert(size(tocka, 2) == 1, "Presečišče bi moralo biti natanko eno.")
fprintf("Abscisa presečišča je %.15f \n", tocka(1))
% 1.533383627431740
% 1.533383875569952 (rešitve)


% 7)
nal(7)
nov_kontrolni_poligon = visanje_stopnje(b);
fprintf("Vsota abscis kontrolnih točk krivulje zvišane stopnje je %f \n", sum(nov_kontrolni_poligon(1, :)))
% 8.75


% 8)
nal(8)
naklon_tangente = @(t) el(odvod(b, 1, t), 2, 1);
nicla = fzero(naklon_tangente, [0 1]);  % [0 1] je interval iskanja
fprintf("Tangentni vektor je z absciso vzporeden pri t = %.15f \n", nicla)
% 0.366025403784439


% 9)
nal(9)
A = [2; 0.5];
razdalja = @(t) norm(deCasteljau(b, t) - A);

% options = optimset('TolFun', 0.0000001);
% t_min_razdalja = fminbnd(razdalja, 0, 1, options);

t_min_razdalja = fminbnd(razdalja, 0, 1);
fprintf("Razdalja točke A do krivulje c je %.15f \n", razdalja(t_min_razdalja))
% 0.626705090228360
% 0.626705079820872 (rešitve)


function [] = nal(n)
    fprintf("\nNaloga %u: \n", n)
end

function [r] = el(A, vrstica, stolpec)
    r = subsref(A, struct('type','()','subs', {{vrstica, stolpec}}));
end