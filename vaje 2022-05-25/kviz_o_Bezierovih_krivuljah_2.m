addpath '..\vaje 2022-05-11'
addpath '..\vaje 2022-05-11\Bezierove krivulje 1'
addpath '..\vaje 2022-05-11\Bezierove krivulje 2'
addpath '..'

seme = 816;
rand('seed', seme);
x2 = 2 + rand(1);

b = [[0; 1], [1; 2], [3; 2], [4; -1]];
c = [[0; 0], [1; -1], [x2; -1], [4; 2]];

% 1)
c_0_5 = deCasteljau(c, 0.5);
nal(1, c_0_5(1))
% 1.825134350429352

% 2)
nal(2, norm(odvod_Bez(c, 1, 0.5)))
% 4.413018274302452

% 3)
nal(3, norm(c_0_5))
% 1.892383522734536

% 4)
nal(4, predznacena_ukrivljenost(c, 0.5))
% 0.555079559766266

% 5)
premica = [[0; 1], [1; -1]];  % y = 1 - x

presecisce = presek_s_premico(c, premica, 0.00000001);

nal(5, presecisce(1))
% 1.570450828839911

% 6)
presecisce2 = presecisce_dveh_krivulj(@(t) deCasteljau(c, t), @(t) deCasteljau(b, t), [0, 0], [1, 1], [0; 0]);

nal(6, presecisce2(2))
% 0.619324933436082

% alternativno
% presecisce2 = presecisce_dveh_krivulj_fsolve(@(t) deCasteljau(c, t), @(t) deCasteljau(b, t), [0, 0], [1, 1], [3; 0.6])
% presecisce2(2)


function nal(n, vrednost)
    fprintf("\nNaloga %u\n", n)
    fprintf("Rešitev: %.15f \n", vrednost)
end
