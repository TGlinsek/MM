function [pred_ukr] = predznacena_ukrivljenost(b, t)
    prvi_odvod = odvod(b, 1, t);
    drugi_odvod = odvod(b, 2, t);

    pred_ukr = (prvi_odvod(1, :).*drugi_odvod(2, :) - prvi_odvod(2, :).*drugi_odvod(1, :))./(prvi_odvod(1, :).^2 + prvi_odvod(2, :).^2).^(3/2);
end

