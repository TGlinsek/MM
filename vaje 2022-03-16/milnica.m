function nov_U = milnica(a, n, f_spodaj, f_zgoraj, f_levo, f_desno, tol, metoda)
    ekvidist_tocke = -a:(2*a/(n + 1)):a;
    
    sp = f_spodaj(ekvidist_tocke);
    zg = f_zgoraj(ekvidist_tocke);
    levo = f_levo(ekvidist_tocke);
    dsn = f_desno(ekvidist_tocke);

    assert(sp(1) == levo(1))
    assert(sp(end) == dsn(1))
    assert(zg(1) == levo(end))
    assert(zg(end) == dsn(end))

    U = [zg; [levo(end - 1:-1:2)', zeros(n, n), dsn(end - 1:-1:2)']; sp];

    switch metoda
        case 'Jacobi'
            nov_U = jacobi(U, tol, a);
        case 'Gauss-Seidel'
            nov_U = gauss_seidel(U, tol, a);
    end
end

