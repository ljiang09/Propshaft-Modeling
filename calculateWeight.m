% returns weight in pounds
% takes in diameter and length values of inches
% density is in kg/m^3
function weight = calculateWeight(D, d, L, density)
    pi = 3.14159265354962;
    R = D/2;
    r = d/2;
    density_imperial = density/27680;  % convert to imperial, lb / in^3

    weight = pi*(R^2-r^2) * L * density_imperial;
end
