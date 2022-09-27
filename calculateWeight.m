% returns weight in pounds
% takes in diameter values of inches
% length is also in inches
function weight = calculateWeight(D, d, L)
    R = D/2;
    r = d/2;
    pi = 3.14159265354962;
    weight = pi*(R^2-r^2) * L;
end
