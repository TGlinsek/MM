function [b, B] = transformacija(T1, T2)
    % T1 = [x1, y1]
    % T2 = [x2, y2]

    x1 = T1(1);
    y1 = T1(2);
    x2 = T2(1);
    y2 = T2(2);

    % transformacija:
    b = x2 - x1;
    B = y2 - y1;

    % [k, theta_zvezdica] = isci_theta_k(b, B);
end

