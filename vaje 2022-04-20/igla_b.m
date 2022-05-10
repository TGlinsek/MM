function [seka] = igla_b(l, t)
    % met igle, b) naloga

    % verjetnost, da igla seka črto, če l < t: P = (2*l)/(pi*t)
    
    % poenostavimo, da gledamo le zgornji del igle (drugače je treba gledati dva pogoja:
    % eden, da seka zgoraj, eden pa, da seka spodaj)
    
    % naključno iglo dobimo z naključnim središčem igle in naključnim kotom:
    % naključni kot med 0 in pi/2:
    x = rand(1);
    y = rand(1);
    while x^2 + y^2 > 1  % če točka pade znotraj kroga (oz. četrt kroga v tem 
       % primeru), bo točka izbrana enakomerno in s tem tudi kot
       x = rand(1);
       y = rand(1);
    end
    % naklon bo zdaj y/x, iz česar bi lahko dobili tudi kot: fi = arctan(y/x)
    
    % paziti smo morali, da nismo uporabili pi-ja pri generiranju
    % naključnega kota, drugače nima smisla (ker se ta metoda lahko uporabi 
    % za računanje pija)

    % naključno izbrano središče:
    % ker l < t, lahko bšs predpostavimo, da se središče (oz. težišče) igle
    % nahaja v zgornji polovici (tj., bližje zgornji črti)
    
    % zanima nas le y koordinata, ne pa tudi x
    
    y_0 = rand() * (t/2);  % ta vrednost bo razdalja do zgornje črte: lahko
    % je kvečjemu t/2
    
    
    % ali igla seka zgornjo črto?
    % l/2 je razdalja od težišča do konice
    
    zgornja_konica = y_0 - y*((l/2)/sqrt(x^2 + y^2));
    seka = zgornja_konica <= 0;

    % opomba: lahko bi simulacijo spisali tudi tako, da odvisna le od l/t,
    % ne pa od l-ja in t-ja posebej
end

