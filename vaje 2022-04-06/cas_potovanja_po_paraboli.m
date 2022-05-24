function [T] = cas_potovanja_po_paraboli(T1, T2)
    % teme v T2
    % iščemo parabolo, da bo čas potovanja najmanjši
    % izkaže se, da je to taka, kjer T2 teme
    % če imamo podan še T1, je parabola natančno določena

    g = 9.81;

    x1 = T1(1);
    y1 = T1(2);
    x2 = T2(1);
    y2 = T2(2);

    % transformacija:
    b = x2 - x1;
    B = y2 - y1;
    
    a = B/b^2;
    y = @(x) -a*(x - b).^2 + B;
    y_ = @(x) -2*a*(x - b);
    
    % če hočeš izrisati parabolo (prestavljeno tako, da se začne v [0, 0]):
    %{
    t = linspace(0, b);
    plot(t, y(t))
    hold on
    plot(0, 0, 'o')
    plot(b, B, 'o')
    %}

    integrand = @(x) sqrt((1 + y_(x).^2)./(-2*g*y(x)));

    T = integral(integrand, 0, b);
end

