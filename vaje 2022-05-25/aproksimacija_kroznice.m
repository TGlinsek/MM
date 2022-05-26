function b = aproksimacija_kroznice(r, fi, risanje, d)
    % APROKSIMACIJA_KROZNICE aproksimira kroznico s Hermiteovo interpolacijo (dvojno ujemanje v robovih intervala).
    % Izracuna kontrolne tocke kubicne Bezierove krivulje, ki aproksimira
    % lok kroznice
    % (cos(t), sin(t)), t \in [-fi,fi].
    % Z vrtenjem Bezierove krivulje za kot 2*fi dobimo zlepek.
    %
    % d...parameter, ki določa dolžino tangentnega vektorja interpolanta v krajiščih intervala [-fi,fi] 
    % Ce parametra d ne predpisemo, naj se izracuna tako, da krivulja dodatno interpolira tocko (1,0) pri  t = 1/2

    % na fi in -fi se mora bezierova krivulja ujemati s krožnico v točki in
    % pa odvod mora imeti isto smer.
    % magnituda odvoda v fi in -fi je določena z d
    % r polmer krožnice

    if nargin < 4
        dolzina_od_nicte_to_prve_kontrolne_tocke = r * 4/3 * (1 - cos(fi))/cos(pi/2 - fi);
        d = dolzina_od_nicte_to_prve_kontrolne_tocke * 3;
    end

    T1 = r * [cos(fi); sin(fi)];
    T2 = r * [cos(-fi); sin(-fi)];
    
    % odvod, če gremo od T1 v T2
    odvod_T1 = d * [cos(fi - pi/2); sin(fi - pi/2)];
    odvod_T2 = d * [cos(-fi - pi/2); sin(-fi - pi/2)];

    b = C1CubicSpline([0, 1], [T1, T2], [odvod_T1, odvod_T2]);

    if risanje
        t = linspace(-fi, fi);
        figure
        plot(r * cos(t), r * sin(t))
        hold on, grid on, axis equal
        % plotBezier(b)
        
        for i = 1 : pi/fi
            rotiraj_bezier(b, i*2*fi, true);
        end
    end
end

