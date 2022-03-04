function [] = risi_kroznici(vhod)
    % na spletni učilnici je boljša/lepša rešitev

    iksi = num2cell(vhod(1, :));
    ipsiloni = num2cell(vhod(2, :));
    
    [x_1, x_2, x_3] = deal(iksi{:});
    [y_1, y_2, y_3] = deal(ipsiloni{:});
    % deal je da lahko več spremenljivk naenkrat definiramo

    % očrtana
    
    k_12 = (y_2  - y_1)/(x_2 - x_1);
    k_23 = (y_3 - y_2)/(x_3 - x_2);
    
    pravokotno = @(k) -1/k;
    
    K_12 = pravokotno(k_12);
    K_23 = pravokotno(k_23);
    
    T_12 = [x_1 + x_2, y_1 + y_2]/2;
    T_23 = [x_2 + x_3, y_2 + y_3]/2;
    
    n_12 = T_12(2) - K_12*T_12(1);
    n_23 = T_23(2) - K_23*T_23(1);
    
    % K_12*x + n_12 := K_23*x + n_23
    x = (n_23 - n_12)/(K_12 - K_23);
    y = K_12*x + n_12;
    
    R = sqrt((x - x_1)^2 + (y - y_1)^2);

    % včrtana
    
    k_31 = (y_1 - y_3)/(x_1 - x_3);
    
    % koeficient simetrale kota:
    simetrala_kota = @(k1, k2, orientacija) tan((atan(k1) + atan(k2) - orientacija*pi)/2);
    % TODO: da formula za koeficient simetrale kota ne bo odvisen od
    % orientacije

    k_1 = simetrala_kota(k_31, k_12, true);
    k_2 = simetrala_kota(k_12, k_23, false);

    n_1 = y_1 - k_1*x_1;
    n_2 = y_2 - k_2*x_2;
    
    x_ = (n_2 - n_1)/(k_1 - k_2);
    y_ = k_1*x_ + n_1;
    
    % stranice
    a = sqrt((x_2 - x_1)^2 + (y_2 - y_1)^2);
    b = sqrt((x_3 - x_2)^2 + (y_3 - y_2)^2);
    c = sqrt((x_1 - x_3)^2 + (y_1 - y_3)^2);

    r = a*b*c/(2 * (a + b + c) * R);  % ena formula

    % risanje
    figure
    plot([x_1 x_2], [y_1 y_2])
    hold on
    plot([x_2 x_3], [y_2 y_3])
    plot([x_3 x_1], [y_3 y_1])
    
    fi = linspace(0, 2*pi);
    
    plot(x + R*cos(fi), y + R*sin(fi))
    plot(x_ + r*cos(fi), y_ + r*sin(fi))

    plot(x, y, 'x')
    plot(x_, y_, 'x')

    daspect([1 1 1])  % enakomerno merilo
end

