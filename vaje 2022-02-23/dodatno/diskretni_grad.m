function [FY, FX] = diskretni_grad(F)
    % čim bolj podobna vgrajeni funkciji 'gradient'

    % vem da naj bi gradient vrnu [FX FY], ampak zgleda so ga narobe
    % sprogramirali, tk da dejansko vrača [FY FX], zato je tut tu tk nareto
    
    % diskretni_grad sprejme matriko F, ki je matrika vrednosti funkcije
    %{
        F =
        x_1, y_1    x_1, y_2,    ...
        x_2, y_1    x_2, y_2,    ...
        ...         ...
    %}

    % privzemimo, da je razdalja med točkami 1, kot naredi tudi vgrajena
    % funkcija 'gradient'. Itak lahk pol kasneje deliš s pravo razdaljo

    % y so horizontalni v matrikah (kot vidimo tudi iz zgornje skice)
    AY = F(:, 2:end) - F(:, 1:end - 1)
    povprecjeY = (AY(:, 2:end) + AY(:, 1:end - 1))/2
    FY = [AY(:, 1) povprecjeY AY(:, end)]
    
    % x so vertikalni v matrikah
    AX = F(2:end, :) - F(1:end - 1, :)
    povprecjeX = (AX(2:end, :) + AX(1:end - 1, :))/2
    FX = [AX(1, :); povprecjeX; AX(end, :)]
end