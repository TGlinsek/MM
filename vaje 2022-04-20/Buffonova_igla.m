% igla dolžine l
% črte so na razdalji t
% kót je fi

% a)
st_metov = 10000000;

stevec_vseh_metov = 0;
stevec_metov_kjer_se_seka = 0;
for i = 1 : st_metov
    if igla_a()  % tu je lahko tudi igla_b(1, 1)
        stevec_metov_kjer_se_seka = stevec_metov_kjer_se_seka + 1;
    end
    stevec_vseh_metov = stevec_vseh_metov + 1;
end
verjetnost = stevec_metov_kjer_se_seka/stevec_vseh_metov;
verjetnost_analiticno = 2/pi;

fprintf("\nl: %d \n", 1)
fprintf("t: %d \n", 1)

fprintf("Verjetnost iz simulacije: %f \n", verjetnost)
fprintf("Analitična verjetnost: %f \n", verjetnost_analiticno)

% b)
% če l < t, je verjetnost, da igla seka črto P = (2*l)/(pi*t)

% primer izbire l-ja in t-ja:
l = 1;
t = 2;

st_metov = 10000000;

stevec_vseh_metov = 0;
stevec_metov_kjer_se_seka = 0;
for i = 1 : st_metov
    if igla_b(l, t)
        stevec_metov_kjer_se_seka = stevec_metov_kjer_se_seka + 1;
    end
    stevec_vseh_metov = stevec_vseh_metov + 1;
end
verjetnost = stevec_metov_kjer_se_seka/stevec_vseh_metov;
verjetnost_analiticno = (2*l)/(pi*t);

fprintf("\nl: %d \n", l)
fprintf("t: %d \n", t)

fprintf("Verjetnost iz simulacije: %f \n", verjetnost)
fprintf("Analitična verjetnost: %f \n", verjetnost_analiticno)

% c)
% če l > t, je verjetnost, da igla seka črto P = 1 - (2/pi)*arcsin(t/l) +
% + (2*l)/(pi*t) - (2/(pi*t))*sqrt(l^2 - t^2)

% primer izbire l-ja in t-ja:
l = 2;
t = 1;

st_metov = 10000000;

stevec_vseh_metov = 0;
stevec_metov_kjer_se_seka = 0;
for i = 1 : st_metov
    if igla_b(l, t)
        stevec_metov_kjer_se_seka = stevec_metov_kjer_se_seka + 1;
    end
    stevec_vseh_metov = stevec_vseh_metov + 1;
end
verjetnost = stevec_metov_kjer_se_seka/stevec_vseh_metov;
verjetnost_analiticno = 1 - (2/pi)*asin(t/l) + (2*l)/(pi*t) - (2/(pi*t))*sqrt(l^2 - t^2);

fprintf("\nl: %d \n", l)
fprintf("t: %d \n", t)

fprintf("Verjetnost iz simulacije: %f \n", verjetnost)
fprintf("Analitična verjetnost: %f \n", verjetnost_analiticno)

% izkaže se, da lahko pri vseh treh primerih uporabimo isto simulacijo za
% met igle. Kar v retrospektivi ni niti malo presenetljivo
