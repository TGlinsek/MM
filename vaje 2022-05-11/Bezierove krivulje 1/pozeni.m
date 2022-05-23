% poženi addpath 'C:\ ... \vaje 2022-05-11\Bezierove krivulje 1'
tocke = [0, 0; 1, 2; 3, 2; 4, -1]';  % nek primer

plotBezier(tocke)
premakni_Bezier(tocke, [zeros(2, 1), zeros(2, 1), [2; 3], zeros(2, 1)], true);
rotiraj_bezier(tocke, pi, true);
zrcali_bezier(tocke, true);
