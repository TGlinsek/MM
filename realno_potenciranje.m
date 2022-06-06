function rez = realno_potenciranje(a, stevec, imenovalec)
    % a je realno število
    % stevec in imenovalec sta celi števili
    % vrne a^(stevec/imenovalec), če je rezultat realno število

    if nargin < 3
        imenovalec = 1;
    end

    assert(imenovalec ~= 0, "Imenovalec ne sme biti 0.")

    if mod(imenovalec, 2) == 0 && a < 0
        if mod(stevec, 2) == 0
            rez = realno_potenciranje(a, stevec/2, imenovalec/2);
        else
            throw(MException("MATLAB:noSolutionFound", "Potenca ne obstaja!"))
        end
    else
        if a == 0
            rez = a^(stevec/imenovalec);
        else
            rez = (sign(a) * (sign(a) * a)^(1/imenovalec))^stevec;
        end
    end
end

