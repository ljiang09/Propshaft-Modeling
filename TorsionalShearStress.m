%% this should be used in sweeps of prop shaft size
% this takes in inches inputs and converts them to meters for formula
% reasons. All formulas are in metric

% D_inches = outer diameter, inches
% d_inches = inner diameter, inches
function [tau, J] = TorsionalShearStress(D_inches, d_inches, T)
    D_meters = D_inches/39.3701;    % unit conversions
    d_meters = d_inches/39.3701;
    r_meters = D_meters/2;  % outermost radius, m

    % polar moment of inertia
    J = calculatePolarMoment(D_meters, d_meters);

    % torque
    tau = calculateTorsionalShearStress(T, r_meters, J);
end

%% calculate torsional shear stress (tau, N/m^2)
% T = torque on shaft, N*m
% r = outermost radius, m
% J = polar moment of inertia, m^4
function tau = calculateTorsionalShearStress(T, r, J)
    tau = T*r/J;
end

%% calculate polar moment of inertia (J)
% J = polar moment of inertia, m^4
% D = outer diameter, m
% d = inner diameter, m

function J = calculatePolarMoment(D, d)
    J = (pi/32) * (D^4 - d^4);
end

