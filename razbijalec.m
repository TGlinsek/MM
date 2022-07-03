function [rez] = razbijalec(f, vrednost)
    % deluje podobno kot map
    % koristno za funkcijo 'integral'

    % vzame funkcijo f, ki sprejme vrednost (ali stolpec)
    % in vrne stolpec iste višine, ter vrne spremenjeno funkcijo,
    % ki deluje tudi na matrikah (tj., na seznamih vrednosti/stolpcev)

    % če vnesemo še drugi parameter, potem razbijalec vrne nov_f(vrednost)
    
    assert(isa(f, 'function_handle'), "Funkcija mora biti tipa function_handle")
    
    nov_f = @(t) nov(f, t);

    if nargin == 1
        rez = nov_f;
    else
        rez = nov_f(vrednost);
    end
end

function X = nov(f, t)
    n = size(t, 2);
    X = zeros(size(f(t(:, 1)), 1), n);
    for i = 1 : n
        X(:, i) = f(t(:, i));
    end
end
    