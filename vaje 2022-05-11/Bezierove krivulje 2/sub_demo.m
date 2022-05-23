function [leva_subdivizija, desna_subdivizija] = sub_demo(b, c, risanje)
    % SUB_DEMO demonstrira en korak subdivizije za ravninsko
    % Bezierovo krivuljo. Pri tem je b tabela 2x(n+1) kontrolnih tock.
    % c je subdivizijski parameter 0 <= c <= 1.

    [~, xs, ys] = deCasteljau(b, c);
    % xs višine s, dolžine n
    % ampak za nas je s = 1

    leva_subdivizija = [xs; ys];  % leva subdivizija je od prve kontrolne točke naprej

    % še desna subdivizija:
    [~, xs, ys] = deCasteljau(b(:, end:-1:1), 1 - c);
    xs = xs(end:-1:1);
    ys = ys(end:-1:1);

    desna_subdivizija = [xs; ys];

    if risanje
        figure
        plotBezier(b)
        hold on
        plotBezier(leva_subdivizija)
        hold on
        plotBezier(desna_subdivizija)
    end
end

