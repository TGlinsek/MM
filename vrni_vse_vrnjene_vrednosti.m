function [rez] = vrni_vse_vrnjene_vrednosti(varargin)
    % prvi argument je funkcija (function handle), ostali argumenti so njeni parametri
    % vrne celično tabelo vrnjenih vrednosti

    % lahko je tudi prvi argument indeks (ali pa celo seznam indeksov), 
    % katero vrnjeno vrednost vrniti.
    % v tem primeru je drugi argument funkcija, ostali pa njeni argumenti

    % TODO: prvi argument je lahko tudi seznam indeksov

    assert(length(varargin) >= 1, "Premalo parametrov!")

    if isa(varargin{1}, 'double')
        f = varargin{2};
        if ~isa(f, 'function_handle')
            throw(MException("", "Če prvi parameter ni oblike function_handle, potem mora tega tipa biti drugi parameter (%d).", f))
        end
        celice = cell(1, nargout(f));
        [celice{:}] = f(varargin{3:end});
        
        try
            rez = celice{varargin{1}};
        catch
            throw(MException("", "Neustrezen prvi parameter! Ni vrnjene vrednosti z indeksom %d.", varargin{1}))
        end

    else
        f = varargin{1};
        if ~isa(f, 'function_handle')
            throw(MException("", "Neustrezen prvi parameter! Prvi parameter (%d) mora biti ali tipa function_handle ali pa seznam števil (double).", f))
        end
        celice = cell(1, nargout(f));
        [celice{:}] = f(varargin{2:end});

        rez = celice;
    end
    
    % https://www.mathworks.com/matlabcentral/answers/96038-how-can-i-capture-an-unknown-number-of-output-arguments-in-a-cell-array-in-matlab-7-5-r2007b
end

