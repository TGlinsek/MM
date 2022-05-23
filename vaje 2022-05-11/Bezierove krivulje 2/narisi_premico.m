function narisi_premico(l)
    tocka = l(:, 1);
    smer = l(:, 2);

    razpotegnjenost = 3;
    tocka1 = tocka - smer * razpotegnjenost;
    tocka2 = tocka + smer * razpotegnjenost;

    x = [tocka1(1), tocka2(1)]';
    y = [tocka1(2), tocka2(2)]';
    line(x, y)
end

