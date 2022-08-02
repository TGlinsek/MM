g = @(f) (@(t) f(t) + 3);
f = @(t) 2*t;

comp(g, f, 1)
comp(comp(g, f), 1)

comp(g, comp(f, 1))