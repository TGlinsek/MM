function [T] = cas_potovanja_po_brahistohroni(T1, T2)
    % čas potovanja kroglice po brahistohroni med T1(x1, y1) in T2(x2, y2)
    
    g = 9.81;  % gravitacijski pospešek

    [k, theta_zvezdica] = transformacija(T1, T2);
    
    T = (k/sqrt(2*g)) * theta_zvezdica;
end