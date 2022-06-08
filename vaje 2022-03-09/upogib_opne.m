function [x] = upogib_opne(f, R, n)
    if nargin < 3
        n = 100;
    end
    h = R/n;
    ekvidist_tocke = 0 : h : (n - 1)*h;  % [0, h, 2h, ..., nh]
    
    if isa(f, 'function_handle')
        f_tocke = f(ekvidist_tocke);
    else
        f_tocke = f;
    end

    D = -2 * ones(1, n);
    P = 1 - 1./(1 : n - 1)/2;
    N = [2, 1 + 1./(1 : n - 2)/2];
    
    x = tridiagonalen_linearen_sistem(D, P, N, h^2*f_tocke);

    %{
    % 2d graf
    figure
    plot([-R, -ekvidist_tocke(end:-1:2), ekvidist_tocke, R], [0, x(end:-1:2)', x', 0]'')
    hold on
    plot([-R, R], [0, 0])
    %}


    % 3d graf
    figure
    f = [x; 0];
    risi_polarno_3d(f, 0, R, 0, 2*pi)
end
