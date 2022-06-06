% ''
dy = @(t, y, y_) sin(t) + y;
resi_dif_1(dy, 0, 2, 100, 1, true);


% a
f = @(t, y, y_) 2*t;
resi_dif_1(f, 0, 5, 100, 1, true);


% b
f = @(t, y, y_) 6*t;
resi_dif_2(f, 0, 5, 100, 1, 0, true);


% bonus primera (nista z vaj)
% rešujemo y'' = t + y + y'

f = @(t, y, y_) t + y + y_;
resi_dif_2(f, 0, 5, 100, 1, 0, true);



% rešujemo y'' = t + 2*y + 3*y'

f = @(t, y, y_) t + 2*y + 3*y_;
resi_dif_2(f, 0, 5, 100, 1, 0, true);
