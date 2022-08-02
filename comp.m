function [y] = comp(varargin)
    % kompozitum
    % za vsakič, ko hočeš napisat f(x)(y), pa ti matlab ne dovoli
    
    assert(length(varargin) >= 1, "Premalo parametrov!")
    
    f = varargin{1};
    if length(varargin) == 1
        y = f;  % vrnemo vrednost, saj je ni s čim komponirati
        return
    end

    x = varargin{2};
    y = comp(f(x), varargin{1, 3:end});
end

