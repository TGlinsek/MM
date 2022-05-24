T1 = [1, 1];
T2 = [3, 0];

x1 = T1(1);
y1 = T1(2);
x2 = T2(1);
y2 = T2(2);


% iz teorije vemo, da je daljica brahistohrona, ko je ΔU(y) = konst. 
% (tj. potencial je neodvisen od višine)


% y'(x):
y_ = -1;  % naklon premice 

% masa kroglice:
m = 1;

delta_U = -1;  % tu si izberemo poljubno negativno število (pač, odvisno, kakšno je potencialno polje)

cas_numericno = integral(@(t) ones(1, length(t)).*sqrt(1 + y_^2)/sqrt((2/m)*(-delta_U)), x1, x2)

% seveda pa se ta izraz poenostavi v

cas_analiticno = sqrt(m*(1 + y_^2))/sqrt(-2*delta_U)*(x2 - x1)
