%% sweeps the torsional shear stresses across thicknesses
% the values to change here are: outer_diameter_range,
% inner_diameter_start, increment_value, T (torque).
% change these values to reflect the range of possible shaft values
clear;
clf;

outer_diameter_range = 0.5 : 0.125 : 3.0;
inner_diameter_start = 0.125;   % since we use outer diameter as the upper limit
increment_value = 0.125;
T = 333.1014;    % torque applied to prop shaft, N*m. Kate's calculations got 245.65 ft-lbs

% figure(1)



%% shear stresses (aka Tensile strength) and shear moduli (aka modulus of rigidity) for various materials
% comment them out as needed. In Pascals as well as N*m^2

% GRAY CAST IRON, https://www.mcmaster.com/drive-shaft-hollow/easy-to-machine-gray-cast-iron-tubes/
% tensile_strength = ncjksancklds;
% shear_modulus = cndjkanlds;

% STEEL ALLOY 4130 (aka chromoly) https://www.mcmaster.com/drive-shaft-hollow/easy-to-weld-4130-alloy-steel-round-tubes/
% tensile_strength = 460 * 10^6;  % 460 MPa
% shear_modulus = 80*10^9;

% STEEL ALLOY 4140 https://www.mcmaster.com/drive-shaft-hollow/multipurpose-4140-alloy-steel-tubes/
% tensile_strength = 655 * 10^6;  % 655 MPa
% shear_modulus = 80*10^9;

% STEEL ALLOY 52100 https://www.mcmaster.com/drive-shaft-hollow/hard-wear-resistant-52100-alloy-steel-tubes/
% tensile_strength = 724 * 10^6;  % 724 MPa
% shear_modulus = 80*10^9;

% LOW CARBON STEEL https://www.mcmaster.com/drive-shaft-hollow/low-carbon-steel-round-tubes/
% tensile_strength = 400 * 10^6;  % 400 – 550 MPa
% shear_modulus = 70*10^9;  % 70.0 - 80.0 GPa

% AHSS CARBON STEEL https://www.mcmaster.com/drive-shaft-hollow/ultra-strength-carbon-steel-ahss-round-tubes/
% tensile_strength = 550 * 10^6;  % 550 MPa
% shear_modulus = 0; % idk

% ALUMINUM ALLOY 7000
tensile_strength = 69 * 10^6;  % 69 MPA
shear_modulus = 25*10^9;  %  25 GPa



G = shear_modulus;

% plot the shear strength of the material
yline(tensile_strength, 'r', 'tensile strength');




hold on;

for D = outer_diameter_range
    torsional_shear_stresses = [];
%     angles_of_twist = [];
    inner_dimensions = [];
    for d = inner_diameter_start : increment_value : D - increment_value
        [tau, J] = TorsionalShearStress(D, d, T);
        inner_dimensions = [inner_dimensions, d];
        torsional_shear_stresses = [torsional_shear_stresses, tau]
        
%         angles_of_twist = [angles_of_twist, calculateAngleOfTwist(T, J, G)];
    end
    % plot the shear stress vs the inner diameter
%     figure(1)
    plot(inner_dimensions, torsional_shear_stresses);
    plot(inner_dimensions, torsional_shear_stresses, '.');
    
    % plot the twist (DOENST WORK RN)
%     figure(2)
%     plot(inner_dimensions, angles_of_twist);
%     disp('angles_of_twist');
%     disp(angles_of_twist);
end

% figure(1)
title('Torsional shear stress of various inner/outer dimensions.')
xlabel('Inner dimension, inches');
ylabel('Torsional shear stress, N/m^2 or Pa');
% legend('0.25 : 0.125 : 4.0');


% figure(2)
% title('Angle of Twist for various inner/outer dimensions');
% xlabel('Inner dimension, inches');
% ylabel('Angle of Twist, Degrees');
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
