function [cas_potovanja, hitrost] = zvVeriznica_cas_in_hitrost(T1, T2, l, v_0)
    % hitrost potovanja kroglice
    % v_0 (zac_hitrost): hitrost pri T1
    
    if nargin < 4
        v_0 = 0;  % privzeta začetna hitrost naj bo 0
    end

    g = 9.81;
    [~, w, w_] = zvVeriznica(T1, T2, l);
    
    hitrost = @(x) sqrt(v_0^2 -2*g*(-T1(2) + w(x)));  
    % to ni težko izpeljati, če upoštevamo da se energija (kinetična + potencialna) ohranja
    
    cas_potovanja = razbijalec( ...
        @(x) integral(@(x_) sqrt((1 + w_(x_).^2)./ ...
        (v_0^2 -2*g*(-T1(2) + w(x_)))), T1(1), x) ...
    );  % v imenovalcu integranda je tu hitrost

    % x (zgornja meja integrala) naj bo med T1(1) in T2(1)
end

