function [k, theta_zvezdica] = isci_theta_k(b, B)
    % funkcija določi theto^*, ki je rešitev enačbe g(theta) = 0
    % T1(0, 0), T2(b, B)
    % [k, theta_zvezdica] = isci_theta_k(b, B)

    g = @(theta) 1 - cos(theta) + B/b * (theta - sin(theta));

    % theta = 0 je trivialna rešitev, ki nas ne zanima
    % toda vemo pa tudi, da obstaja še natanko ena rešitev na
    % intervalu (0, 2pi)
    % splača se vzeti približek, ki je bližje 2pi, da nam iteracija
    % skonvergira k tej ničli in ne k trivialni
    tol = 0.0001;
    theta_zvezdica = navadna_iteracija(g, pi, tol);
    
    k = sqrt(2*b/(theta_zvezdica - sin(theta_zvezdica)));
end

