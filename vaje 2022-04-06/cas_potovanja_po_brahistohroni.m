function [T] = cas_potovanja_po_brahistohroni(T1, T2)
    % čas potovanja kroglice po brahistohroni med T1(x1, y1) in T2(x2, y2)
    
    g = 9.81;  % gravitacijski pospešek

    [b, B] = transformacija(T1, T2);
    [k, theta_zvezdica] = isci_theta_k(b, B);
    

    T = k/sqrt(2*g) * theta_zvezdica;

    % opomba: če hočemo zračunati čas potovanja po brahistohroni do neke
    % thete (0 <= theta <= theta_zvezdica), potem velja
    % T = k/sqrt(2*g) * theta
end