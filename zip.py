# folder 'uporabljene_datoteke' mora biti na začetku prazen

import shutil
import os


def vrni_trenutno_pot():  # pot do datoteke, v kateri je izveden ta ukaz
    return os.path.dirname(os.path.realpath(__file__))

trenutna_pot = vrni_trenutno_pot()


"""
# te funkcije ne potrebujemo

def pridobi_starša(pot=vrni_trenutno_pot()):
    # pridobi starševski folder glede na podano pot
    # obstaja malce boljši način, kjer uvozimo knjižnico Path, ampak zaenkrat bom uporabil le os knjižnico
    return os.path.abspath(os.path.join(pot, os.pardir))
"""


def združi_s_trenutno_potjo(fajl):
    return os.path.join(trenutna_pot, fajl)

pot_do_uporabljenih_datotek = združi_s_trenutno_potjo('uporabljene_datoteke')


def kopiraj(fajl):
    shutil.copy(fajl, pot_do_uporabljenih_datotek)


def ustvari_kopije(matlab_funkcije):
    # če v matlabu vstavimo cell, bo v pythonu to pršlo ven kot tuple
    for i in matlab_funkcije:
        kopiraj(i)


def zazipaj(matlab_funkcije):
    if not os.path.exists(pot_do_uporabljenih_datotek):  # če mapa 'uporabljene_datoteke' ne obstaja
        os.mkdir(pot_do_uporabljenih_datotek)  # ustvarimo mapo
    
    ustvari_kopije(matlab_funkcije)
    shutil.make_archive(pot_do_uporabljenih_datotek, 'zip', pot_do_uporabljenih_datotek)
    # to zazipa cel folder, ki je tretji parameter, in ga shrani v datoteko, ki je prvi parameter + končnica, ki je drugi parameter
    
    # shutil.make_archive(združi_s_trenutno_potjo('uporabljene_datoteke\\ime_zipa'), 'zip', pot_do_uporabljenih_datotek) je slabo, kr maš pol zip v zipu
