function [vrednost_integrala] = monte_carlo3(f, a1, b1, a2, b2, a3, b3, N)
    % trodimenzionalni monte carlo (je analogno funkciji monte_carlo1)
    % N = št. točk
    
     nakljucne_tocke_x = rand(1, N) * (b1 - a1) + a1;
     nakljucne_tocke_y = rand(1, N) * (b2 - a2) + a2;
     nakljucne_tocke_z = rand(1, N) * (b3 - a3) + a3;
     nakljucne_vrednosti = f(nakljucne_tocke_x, nakljucne_tocke_y, nakljucne_tocke_z);

     povprecna_vrednost = sum(nakljucne_vrednosti)/N;

     % znana formula, ki povezuje integral s povprečno vrednostjo:
     vrednost_integrala = povprecna_vrednost * (b1 - a1) * (b2 - a2) * (b3 - a3);
end

