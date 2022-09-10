function [rez] = zasuci(x, y, kot, okoli_tocke)  % zasuk v pozitivni smeri
    % v radianih
    % okoli_tocke je točka, okoli katere sukamo

    if nargin < 4
        okoli_tocke = [0; 0];
    end
    
    R = [cos(kot), -sin(kot); sin(kot), cos(kot)];
    rez = R * ([x; y] - okoli_tocke) + okoli_tocke;

    % x_ = rez(1);
    % y_ = rez(2);
end

