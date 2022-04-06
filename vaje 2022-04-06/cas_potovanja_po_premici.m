function [T] = cas_potovanja_po_premici(T1, T2)
    % čas potovanja kroglice po premici med T1(x1, y1) in T2(x2, y2)
    
    x1 = T1(1);
    y1 = T1(2);
    x2 = T2(1);
    y2 = T2(2);

    g = 9.8;  % gravitacijski pospešek

    naklon = (y2 - y1)/(x2 - x1);

    % "dinamična sila", v bistvu njen pospešek
    dinamicna_sila = g * sin(arctan(abs(naklon)));
    
    T = cas_iz_pospeska_in_razdalje(dinamicna_sila, sqrt((x1 - x2)^2 + (y1 - y2)^2));
    
    function [T] = cas_iz_pospeska_in_razdalje(a, s)
        % pospešek: a
        % razdalja: s
        % če imamo premočrtno gibanje s konstantnim pospeškom, lahko izračunamo
        % čas T
        
        T = sqrt(2*s/a);
    end
end

