function seka = seka_mnogokotnik(l, P, risanje)
    % Doloci, ali premica l seka konveksno ogrinjaco tock P (=mnogokotnik) ali ne.
    % Premica l je podana v obliki l = [tocka, smerni].
    % Mnogokotnik P je dolocen s tabelo 2xn oglisc po stolpcih
    
    if nargin == 2
        risanje = false;
    end

    if risanje
        figure
        narisi_mnogokotnik(P);
        narisi_premico(l);
    end

    stari_breg = 0;  % samo na začetku bo to enako 0
    for t = P
        breg = vrni_breg(l, t);
        if breg == 0
            seka = true;
            return
        else
            if breg == stari_breg || stari_breg == 0
                % ne naredi nič
                % stari_breg == 0 se bo zgodilo le prvič
            else
                seka = true;
                return
            end
            stari_breg = breg;
        end
    end
    seka = false;
end

function breg = vrni_breg(premica, tocka)
    % vrne 1, če je na levem bregu, in -1, če je na desnem
    % če leži na premici, potem vrne 0

    matrika = [tocka - premica(:, 1), premica(:, 2)];

    breg = sign(det(matrika));

    % opomba: lahko bi šli tudi drugače:
    % vzamemo normalo n na premico in si izberemo točko s na premici
    % pogledamo predznak <n, b - s>, kjer b kontrolna točka
end