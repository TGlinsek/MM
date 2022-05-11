function [delez] = vrata(n, strategija)
    % če strategija true: zamenjamo vrata
    % če strategija false: ostanemo zvesti pri izbiri

    stevec = 0;
    stevilo_zadetkov = 0;
    for i = 1 : n
        % predpostavimo, da smo izbrali prva vrata
        zmagovalna_vrata = randi(3);
        if zmagovalna_vrata == 1
            odprta_vrata = randi(2) + 1;
        else
            odprta_vrata = 5 - zmagovalna_vrata;
        end
        if strategija
            izbrana_vrata = 5 - odprta_vrata;
        else
            izbrana_vrata = 1;
        end
        ali_smo_zadeli = zmagovalna_vrata == izbrana_vrata;
            
        stevilo_zadetkov = stevilo_zadetkov + ali_smo_zadeli;
        stevec = stevec + 1;
    end
    delez = stevilo_zadetkov/stevec;
end

