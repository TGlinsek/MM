% prvi testni primer

T1 = [1; 5];
T2 = [7; 3];

risi_brah(T1, T2)

cas_potovanja_po_brahistohroni(T1, T2);
izpis("Čas potovanja po brahistohroni: ", ans)
cas_potovanja_po_premici(T1, T2);
izpis("Čas potovanja po premici: ", ans)
cas_potovanja_po_paraboli(T1, T2);
izpis("Čas potovanja po (najoptimalnejši) paraboli: ", ans)


% drugi testni primer

T1 = [1, 1];
T2 = [3, 0];

cas_potovanja_po_brahistohroni(T1, T2);
izpis("Čas potovanja po brahistohroni: ", ans)
cas_potovanja_po_premici(T1, T2);
izpis("Čas potovanja po premici: ", ans)

najnizja_tocka(T1, T2);
izpis("Najnižja točka je pri x = ", ans)

dolzina_loka(T1, T2);
izpis("Dolžina loka: ", ans)

function izpis(txt, var)
    fprintf(txt + "%0.15f \n", var);
end
