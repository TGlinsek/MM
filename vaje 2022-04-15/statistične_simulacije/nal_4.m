% vrednost določenega integrala je povprečna vrednost krat dolžina
% intervala

% izberemo naključne točke na intervalu, vzamemo njihove vrednosti in
% delimo s številom točk, da dobimo povprečje


f = @(x) sqrt(1 - x.^2);
ploscina_polkroga = monte_carlo1(f, -1, 1, 10000000);
priblizek_za_pi = ploscina_polkroga * 2

% hitrost konvergence lahko izračunamo kot:
% log(err_1/err_2)/log(N_1/N_2)

% narišimo graf konvergence:

odstopanja = [];
for i = 0 : 8
    ploscina_polkroga = monte_carlo1(f, -1, 1, 10^i);
    priblizek_za_pi = ploscina_polkroga * 2;
    odstopanje = abs(priblizek_za_pi - pi);
    odstopanja(i + 1) = odstopanje;
end

daspect([1 1 1])

semilogy(0 : 8, odstopanja)  % tako kot plot, ampak logaritemsko
% ta ima le ordinato logaritemsko

% ekvivalentno bi bilo:
% loglog((10*ones(1, 9)).^(0 : 8), odstopanja)
% ta ima obe osi logaritemski

% dobimo nekaj, kar bi moralo spominjati na premico
% iz naklona premice lahko dobimo red konvergence:

n = length(odstopanja);
nakloni = (log(odstopanja(2:end)) - log(odstopanja(1:end - 1)))./(log(10.^(1:n - 1)) - log(10.^(0:n - 2)));
povprecje = mean(nakloni);  % povprečni naklon

fprintf("Povprečni naklon: %f \n", povprecje)

% konvergenca je linearna (če privzamemo, da N narašča s potencami od 10), 
% saj je vsaka naslednja napaka enaka prejšnji krat nek fiksen faktor 
% (ta faktor je 10^naklon)

% no, če privzamemo, da N narašča linearno, potem je red konvergence še vedno
% linearen

% več o tem: https://en.wikipedia.org/wiki/Log%E2%80%93log_plot