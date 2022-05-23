addpath '..\vaje 2022-05-11'
addpath '..\vaje 2022-05-11\Bezierove krivulje 1'
addpath '..\vaje 2022-05-11\Bezierove krivulje 2'

b = [[3;1], [6;-2], [9;4], [12; 6], [6; -5]];

tangentni_vektor = bezier_der(b, 0.5);

p = [[1;1] [2;-2] [3;4] [4;6] [2; -5]];
v = [[1;1] [1; -1] [1; -3] [1; -1] [-1; 1]];

alfa = 0.5;
hold off
parametrizacija(alfa, p, v, true);