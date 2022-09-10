%{
Standardna baza:
- 1, x, x^2, ...
- nestabilna in numerično slaba

Newtonova baza:
- phi_0(x) ≡ 1
- phi_j(x) = (x - x_0)(x - x_1)...(x - x_(j - 1)), za j = 1, ..., n
- dobra za hitro evalvacijo v določenih točkah

Bernsteinova baza:
- phi_j(x) = Binom(n, j) * x^j * (1 - x)^(n - j)
- seštejejo se v 1, po binomskem izreku. To naredi bazo stabilno (??).
- vse bazne funkcije so nenegativne na [0, 1], kar je dobro iz numeričnega vidika
- dobro za konveksne kombinacije (baricentrične koordinate)
%}
