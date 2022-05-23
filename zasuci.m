function [rez] = zasuci(x, y, kot)  % zasuk v pozitivni smeri
    % v radianih
    
    R = [cos(kot), -sin(kot); sin(kot), cos(kot)];
    rez = R * [x; y];

    % x_ = rez(1);
    % y_ = rez(2);
end

