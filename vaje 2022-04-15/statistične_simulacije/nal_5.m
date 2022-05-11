% podobno kot nal_4, ampak večdimenzionalno

% primer
f = @(x, y, z) x + y.^2 + z.^3;

a1 = -1;
b1 = 1;
a2 = -2;
b2 = 2;
a3 = -3;
b3 = 3;

priblizek = monte_carlo3(f, a1, b1, a2, b2, a3, b3, 10000000)
matlabov_priblizek = integral3(f, a1, b1, a2, b2, a3, b3)