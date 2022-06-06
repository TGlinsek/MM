function [ro_z] = gostota_zraka(visine, gostote)
    % sprejme seznam
    % vrne polinom ro_z(y), kjer ro_z(0) gostota zraka na tleh
    assert(size(visine, 1) == 1 && size(gostote, 1) == 1)
    assert(size(visine, 2) == size(gostote, 2))

    transformacija = @(x) ((x - 40000)./40000).^2;
    visine = transformacija(visine);
    % A = [(1 : length(visine))', visine', visine.^2'];  % alternativna metoda
    % za najmanjše kvadrate, ampak očitno ne dela čist prav. Bolje: polyfit
    % x = lsqr(A, gostote');  % least squares
    
    x = flip(polyfit(visine, gostote, 2))';  % boljši least squares
    
    % naš polinom:
    ro_z = @(y) x(1) + x(2).*transformacija(y) + x(3).*transformacija(y).^2;
end

