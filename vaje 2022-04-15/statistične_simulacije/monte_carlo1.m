function [vrednost_integrala] = monte_carlo1(f, a, b, N)
     % vrne približek za int_a^b f(x) dx
     % približek se računa z N točkami

     nakljucne_tocke = rand(1, N) * (b - a) + a;
     nakljucne_vrednosti = f(nakljucne_tocke);

     povprecna_vrednost = sum(nakljucne_vrednosti)/N;

     % znana formula, ki povezuje integral s povprečno vrednostjo:
     vrednost_integrala = povprecna_vrednost * (b - a);

     
end

