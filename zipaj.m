function zipaj()
    % zazipa vse datoteke, ki smo jih uporabili v fajl1.m in fajl2.m skupaj
    % tj., zazipa unijo vseh teh datotek
    
    % folder uporabljene_datoteke mora na začetku biti prazen

    addpath(genpath(pwd))  % da vse podmape v path
    a = matlab.codetools.requiredFilesAndProducts('fajl1.m');
    b = matlab.codetools.requiredFilesAndProducts('fajl2.m');
    c = [a b];
    py.zip.zazipaj(c)
end