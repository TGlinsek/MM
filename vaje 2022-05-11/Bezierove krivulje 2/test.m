tocke = [0, 0; 1, 2; 3, 2; 4, -1]';

sub_demo(tocke, 0.5, true);


P = [[1;2], [3;4], [5; 7]];
l = [[10;2], [1;-1]];
ali_seka = seka_mnogokotnik(l, P);
ali_seka


P = [[1;2], [3;4], [5; 7]];
l = [[10;1], [1;-1]];
ali_seka2 = seka_mnogokotnik(l, P);
ali_seka2


P = [3 2 4 9/2 5;-1 0 3/2 1 -1];
l = [2 1; -1 1];
tocke = presek_s_premico(P, l, 0.000001, true);
tocke