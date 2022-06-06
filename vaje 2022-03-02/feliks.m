function [y, y_] = feliks(g, ro_z, c_u, S, m, n, t_K, zacetna_visina, zacetna_hitrost, risanje)
    % g(y) funkcija, g(0) je g na tleh
    % ro_z(y) funkcija, ro_z(0) je ro na tleh
    % c_u je konstanta: koeficient zračnega upora
    % S: prečna površina padalca (tj., prerez)
    % m: masa feliksa in obleke
    % zacetna_visina: višina pri t_0. Recimo 40000
    % zacetna_hitrost: hitrost pri t_0. Pozitivna pomeni, da gre padalec na
    % začetku navzgor
    
    % n: št točk, vključno s t_0 in t_K. Razdelijo interval [t_0, t_K]
    % n je ponavadi 10000
    % t_0 je ponavad kr enak 0
    t_0 = 0;  % če to spremeniš, je še treba popravit začetne pogoje pri reševanju dif enačbe, če hočeš nastavit y(t_0) in y'(t_0)
    % če pa rabiš sam y(0) in y'(0), potem pa ni treba skrbeti
    
    if isa(g, 'double')
        g = @(y) g;
    end

    if isa(ro_z, 'double')
        ro_z = @(y) ro_z;
    end

    if nargin < 10
        risanje = false;
    end

    nekonkreten_f = @(g, ro_z, c_u, S, m, y_) -g - (ro_z .* c_u .* S./(2.*m)).*y_.*abs(y_);
    f = @(t, y, y_) nekonkreten_f(g(y), ro_z(y), c_u, S, m, y_);

    [y, y_] = resi_dif_2(f, t_0, t_K, n, zacetna_visina, zacetna_hitrost, risanje);
end