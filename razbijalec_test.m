f = @(t) 1;
% integral(f, 0, 1) this doesn't work

nov_f = razbijalec(f);
integral(nov_f, 0, 1)

% or:
integral(@(t) razbijalec(f, t), 0, 1)

% integral od sin(f)
integral(razbijalec(@(u) sin(f(u))), 0, 1)

integral(@(t) sin(razbijalec(f, t)), 0, 1)

% recimo, če bi kdaj morali napisati nekaj kot je razbijalec(f)(t)
% potem se to v matlabu ne prevede. Zato pa lahko pišemo razbijalec(f, t)
