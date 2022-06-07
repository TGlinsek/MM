function [area] = polygon_area(X, Y)
    % povzeto po: https://www.geeksforgeeks.org/area-of-a-polygon-with-given-n-ordered-vertices/
    
    n = length(X);
    assert(length(Y) == n, "Napačne dimenzije!")

    area = 0.0;
  
    %{
    j = n;
    for i = 1 : n
        area = area + (X(j) + X(i)) * (Y(j) - Y(i));
        j = i;
    end
    %}


    % povzeto po: https://www.mathworks.com/matlabcentral/answers/153442-finding-the-area-using-shoelace-polygon-formula
    X = [X, X(1)];
    Y = [Y, Y(1)];

    for i = 1 : n
        area = area + det([X(i), X(i+1); Y(i), Y(i+1)]);
    end

    area = area/2;
    area = abs(area);
end

