st_poskusov = 1000000;
fprintf("Če ne zamenjamo: %f \n", vrata(st_poskusov, false))  % analitično: 1/3
fprintf("Če ne zamenjamo (analitično): %f \n", 1/3)
fprintf("Če zamenjamo: %f \n", vrata(st_poskusov, true))  % analitično: 2/3
fprintf("Če zamenjamo (analitično): %f \n", 2/3)

N = 10;  % št vrat
fprintf("\nČe ne zamenjamo (%d vrat): %f \n", N, vec_vrat(st_poskusov, false, N))  % analitično: 1/N
fprintf("Če ne zamenjamo (%d vrat) (analitično): %f \n", N, 1/N)
fprintf("Če zamenjamo (%d vrat): %f \n", N, vec_vrat(st_poskusov, true, N))  % analitično (N - 1)/(N(N - 2))
fprintf("Če zamenjamo (%d vrat) (analitično): %f \n", N, (N - 1)/(N*(N - 2)))

% gostitelj vedno odpre le ena vrata (s kozo)