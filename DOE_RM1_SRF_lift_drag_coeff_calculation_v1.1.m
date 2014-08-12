% 3D lift and drag coefficients calculation for the full-scale model MHK
% turbine (DOE RM1). Force data exctrated from SRF simulations
% in ANSYS FLUENT. 

clc;
clear all;
close all;

%=====User Inputs==============
%Operating conditions
roh=1025;     %Density in [kg/m^3]
v_inf=1.9;    %Free stream velocity in [m/sec]
v_local=1.4;  %1D Upstream velocity in [m/sec]
omega=1.2;    %Turbine Anguler velocity in [rad/sec]

%Blade geometry specifications
pitch_angle=0;

file_geometry='DOE_ref_model1_geometry_28sections.txt';
fid_geometry=fopen(file_geometry,'r');

for j=1
    fgetl(fid_geometry);
end
C_geometry = textscan(fid_geometry, '%f %f %f %f %f');
fclose(fid_geometry);

radius=C_geometry{1};
twist=C_geometry{2};
chord=C_geometry{3};
pitch(1:size(radius),1)=pitch_angle;
thickness=C_geometry{5};

line_to_skip=39;
line_to_skip_center_of_pressure=4;
%=====End User Inputs==============


%===== Reading/Sorting Streamwise and Perpendicular Forces========%
%=====  on Each Blade Section Extracted from ANSYS FLUENT ========%

%=====Forces in the streamwise direction==============
file='fy_seawater_KW.txt';
fid=fopen(file,'r');

for j=1:line_to_skip
    fgetl(fid);
end
C_y = textscan(fid, '%s %f %f %f %f %f %f');
fclose(fid);
temp_y=C_y{4};     

%Data rearrangment from root to the tip of the blade
F_y(1:2,1)=temp_y(1:2,1);       %blade0 and 1
F_y(3,1)=temp_y(13,1);          %blade2
F_y(4:10,1)=temp_y(22:28,1);    %blade3  to 9    
F_y(11:20,1)=temp_y(3:12,1);    %blade10 to 19
F_y(21:28,1)=temp_y(14:21,1);   %blade20 to 27
clear temp_x temp_y;

%=====Forces perpendicular to streamwise direction==============
file='fx_seawater_KW.txt';
fid=fopen(file,'r');

for j=1:line_to_skip
    fgetl(fid);
end
C_x = textscan(fid, '%s %f %f %f %f %f %f');
fclose(fid);
temp_x=C_x{4};

%Data rearrangment from root to the tip of the blade
F_x(1:2,1)=temp_x(1:2,1);       %blade0 and 1
F_x(3,1)=temp_x(13,1);          %blade2
F_x(4:10,1)=temp_x(22:28,1);    %blade3  to 9    
F_x(11:20,1)=temp_x(3:12,1);    %blade10 to 19
F_x(21:28,1)=temp_x(14:21,1);   %blade20 to 27

%=====Center of presure along the blad span sections==============
file='center_of_pressure_seawater_kw.txt';
fid=fopen(file,'r');

for j=1:line_to_skip_center_of_pressure
    fgetl(fid);
end
C_x = textscan(fid, '%s %f %f');
fclose(fid);
temp_Z_p=C_x{3};

%Data rearrangment from root to the tip of the blade
Z_p(1:2,1)=temp_Z_p(1:2,1);       %blade0 and 1
Z_p(3,1)=temp_Z_p(13,1);          %blade2
Z_p(4:10,1)=temp_Z_p(22:28,1);    %blade3 to 9    
Z_p(11:20,1)=temp_Z_p(3:12,1);    %blade10 to 19
Z_p(21:28,1)=temp_Z_p(14:21,1);   %blade20 to 27
clear temp_Z_p;

%=====End Reading ANSYS FLUENT Outputs====================

%=====Lift/Drag Coefficiect and Turbine Integral Variable Calculation=====%
beta=atan(v_local./(radius.*omega));   %Angle of relative wind in [rad]
v_rel=(v_local^2.+(radius.*omega).^2); %Square of relativ velocity in [m/s]
AOA=(beta.*(180/pi))-twist-pitch;

lift_force=F_y.*cos(beta)+F_x.*sin(beta);  %in [N]
drag_force=F_y.*sin(beta)-F_x.*cos(beta);  %in [N]

lift_coeff=lift_force./(0.5*roh*0.3*chord.*v_rel);
drag_coeff=drag_force./(0.5*roh*0.3*chord.*v_rel);

torque=F_x.*Z_p;

%===== Calculating Integral variables=====%
power=2*sum(torque)*omega/1000  %in [kW]
power_section=torque.*omega/(mean(thickness)*1000);   %in [kW/m]
efficiency=(power*1000)/(0.5*roh*v_inf^3*pi*(10^2-2.8^2))


figure(1)
plot(radius,power_section,'*-')
hleg2=title('Sectional power along span of one turbine blade');
set(hleg2,'interpreter','Latex','FontSize',12);
xlabel('Radius [m]','interpreter','latex','FontSize',12)
ylabel('Sectional Power [kW/m]','interpreter','Latex','FontSize',12)
grid on

figure(2)
ax1 = gca;
hold on
plot(radius,AOA,'k*-')
hold on
xlabel('Radius [m]','interpreter','latex','FontSize',12)
ylabel('AOA [-]','interpreter','Latex','FontSize',12)
ax2 = axes('Position',get(ax1,'Position'),...
       'YAxisLocation','right',...
       'Color','none');
ylabel('$C_{L}$ and $C_{D}$ [-]','interpreter','Latex','FontSize',12)
linkaxes([ax1 ax2],'x');
hold on
plot(radius,lift_coeff,'g*-')
plot(radius,drag_coeff,'r*-')
hleg2 = legend('Lift Coefficient','Drag Coefficient','Angle of Attack');
set(hleg2,'Location','NorthEast','interpreter','Latex','FontSize',12)
grid on