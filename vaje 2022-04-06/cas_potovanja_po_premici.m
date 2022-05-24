function [T, koncna_hitrost] = cas_potovanja_po_premici(T1, T2, zac_hitrost)
    % čas potovanja kroglice po premici med T1(x1, y1) in T2(x2, y2)
    
    if nargin < 3
        zac_hitrost = 0;
    end

    x1 = T1(1);
    y1 = T1(2);
    x2 = T2(1);
    y2 = T2(2);

    g = 9.81;  % gravitacijski pospešek

    naklon = (y2 - y1)/(x2 - x1);

    % "dinamična sila", v bistvu njen pospešek
    dinamicna_sila = g * sin(atan(abs(naklon)));
    
    razdalja = sqrt((x1 - x2)^2 + (y1 - y2)^2);

    if razdalja == 0
        T = 0;
    else
        T = cas_iz_pospeska_in_razdalje(dinamicna_sila, razdalja, zac_hitrost);
    end
    
    koncna_hitrost = zac_hitrost + T * dinamicna_sila;
    
    function [T] = cas_iz_pospeska_in_razdalje(a, s, u)
        % pospešek: a
        % razdalja: s
        % začetna hitrost: u
        % če imamo premočrtno gibanje s konstantnim pospeškom, lahko izračunamo
        % čas T
        
        if a == 0
            T = s/u;
            return
        end

        % T = sqrt(2*s/a);  % to je, če u = 0
        T = (sqrt(u^2 + 2*a*s) - u)/a;
    end
end

