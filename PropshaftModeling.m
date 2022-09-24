%% sweeps the torsional shear stresses across thicknesses
% the values to change here are: outer_diameter_range,
% inner_diameter_start, increment_value, T (torque).
% change these values to reflect the range of possible shaft values
clear;
clf;

outer_diameter_range = 1.5 : 0.125 : 5.0;
inner_diameter_start = 1.0;   % since we use outer diameter as the upper limit
increment_value = 0.125;
T = 400;    % torque applied to prop shaft, N*m


figure(1)
% plot minimum shear strength values on the same line.
% Units of Pa or N*m^2.
% supposedly it means how much torsional stress it can take before fail
aluminum_shear_stress = 207 * 1000000; % Pa
% carbon_steel_shear_stress = 260;
% alloy_structural_steel = 400;
% DOM steel?
% Chromoly ?

yline(aluminum_shear_stress, 'r', 'aluminum shear strength');
% TODO: fix this.. idk what values i'm plotting

% TODO: comment them out as needed
% in Pascals as well as N*m^2
G = 77*10^9;    % Steel


hold on;
for D = outer_diameter_range
    torsional_shear_stresses = [];
    angles_of_twist = [];
    inner_dimensions = [];
    for d = inner_diameter_start : increment_value : D - increment_value
        [tau, J] = TorsionalShearStress(T, D, d);
        inner_dimensions = [inner_dimensions, d];
        torsional_shear_stresses = [torsional_shear_stresses, tau];
        
        angles_of_twist = [angles_of_twist, calculateAngleOfTwist(T, J, G)];
    end
    % plot the shear stress vs the inner diameter
    figure(1)
    plot(inner_dimensions, torsional_shear_stresses);
    plot(inner_dimensions, torsional_shear_stresses, '.');
    
    % plot the twist (DOENST WORK RN)
    figure(2)
    plot(inner_dimensions, angles_of_twist);
    disp('angles_of_twist');
    disp(angles_of_twist);
end

figure(1)
title('Torsional shear stress of various inner/outer dimensions.')
xlabel('Inner dimension, inches');
ylabel('Torsional shear stress, N/m^2 or Pa');
% legend('0.25 : 0.125 : 4.0');


figure(2)
title('Angle of Twist for various inner/outer dimensions');
xlabel('Inner dimension, inches');
ylabel('Angle of Twist, Degrees');
hold off;


% TODO: find the lightest weight and material
% plot weight vs. dimensions

%% Angle of twist - material-based
% L = length of the shaft, m (you should just choose a reasonable arbitrary value)
% T = torque applied to the shaft, N*m
% J = polar moment of inertia
% G = shear modulus, N/m^2
% the values you should be changing here are the length and modulus. Change
% the modulus to fit the material you're looking at

function theta_degrees = calculateAngleOfTwist(T, J, G)
    L_inches = 36;
    L = L_inches/39.3701;    % meters

    theta_radians = (T*L) / (J*G);
    theta_degrees = theta_radians*360/(2*3.141);
end


%% Storage values to compare
% Shear stress value for the ____: 
