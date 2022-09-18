%% sweeps the torsional shear stresses across thicknesses
% the values to change here are: outer_diameter_range,
% inner_diameter_start, increment_value, T (torque).
% change these values to reflect the range of possible shaft values
clear all;

outer_diameter_range = 0.25 : 0.125 : 2.0;
inner_diameter_start = 0.125;   % since we use outer diameter as the upper limit
increment_value = 0.125;
T = 400;    % torque applied to prop shaft, N*m

hold on;
for D = outer_diameter_range
    torsional_shear_stresses = [];
    inner_dimensions = [];
    for d = inner_diameter_start : increment_value : D-increment_value
        % shear stress vs. inner diameter
        [tau, ~] = TorsionalShearStress(D, d);
        inner_dimensions = [inner_dimensions, d];
        torsional_shear_stresses = [torsional_shear_stresses, tau];
    end
    % plot the shear stress vs the inner diameter
    plot(inner_dimensions, torsional_shear_stresses);
end

title('Torsional shear stress of various inner/outer dimensions.')
xlabel('Inner dimension, inches');
ylabel('Torsional shear stress, N/m^2');
% legend('0.25 : 0.125 : 4.0');
hold off;


%% Angle of twist - material-based
% L = length of the shaft, m (you should just choose a reasonable arbitrary value)
% T = torque applied to the shaft, N*m
% J = polar moment of inertia
% G = shear modulus, N/m^2
% the values you should be changing here are the length and modulus. Change
% the modulus to fit the material you're looking at

L_inches = 36;
L = L_inches/39.3701;    % meters
% how to get all the J values?
G = 77*10^9;    % this is in Pascals as well as N*m^2

theta_radians = (T*L) / (J*G);

theta_degrees = theta*360/(2*3.141);


%% Storage values to compare
% Shear stress value for the ____: 
