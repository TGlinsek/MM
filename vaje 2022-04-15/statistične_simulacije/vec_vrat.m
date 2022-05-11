function [delez] = vec_vrat(n, strategija, N)
    % če strategija true: zamenjamo vrata
    % če strategija false: ostanemo zvesti pri izbiri

    stevec = 0;
    stevilo_zadetkov = 0;
    for i = 1 : n
        % predpostavimo, da smo izbrali prva vrata
        zmagovalna_vrata = randi(N);
        if zmagovalna_vrata == 1
            odprta_vrata = randi(N - 1) + 1;
        else
            while true
                odprta_vrata = randi(N - 1) + 1;
                if odprta_vrata ~= zmagovalna_vrata
                    break
                end
            end
        end
        if strategija
            if odprta_vrata ~= 2
                izbrana_vrata = 2;
            else
                izbrana_vrata = 3;
            end
        else
            izbrana_vrata = 1;
        end
        ali_smo_zadeli = zmagovalna_vrata == izbrana_vrata;
            
        stevilo_zadetkov = stevilo_zadetkov + ali_smo_zadeli;
        stevec = stevec + 1;
    end
    delez = stevilo_zadetkov/stevec;
end
