ruggles_imu = readtable('/MATLAB Drive/donut/donutimu.csv');
circleimumagx = table2array(ruggles_imu(:,"mag_field_magnetic_field_x"));
circleimumagy = table2array(ruggles_imu(:,"mag_field_magnetic_field_y"));
%% Magnetometer Calibration

%Hard iron factor elimination
offsetx = (max(circleimumagx)+min(circleimumagx))/2;
offsety = (max(circleimumagy)+min(circleimumagy))/2;

hardcorrectedmagvalue = [(circleimumagx-offsetx), (circleimumagy-offsety)];

%%
%SoftIron
[z0, a0, b0, alpha0] = fitellipse(hardcorrectedmagvalue);
M = [cos(alpha0+pi), sin(alpha0+pi); -sin(alpha0+pi), cos(alpha0+pi)];
correct_inclinationmag = M*hardcorrectedmagvalue';

[z1,a1,b1,al1] = fitellipse(correct_inclinationmag);  %to check for the major axis and
%minor axis values are correct or not.
gamma = a0/b0;
softcorrectmagx = (correct_inclinationmag(1,:)/gamma);
softcorrectmagy = (correct_inclinationmag(2,:));

%%

%Plot
% Mag Original
figure;
plot(circleimumagx,circleimumagy,"red")
hold on;
xlabel("Original Mag-x data(Gauss)")
ylabel("Original Mag-y data(Gauss)")
title('Original Magnatometer Data')
grid on
hold off;

%Hard Iron vs original
figure;
plot(hardcorrectedmagvalue(:,1),hardcorrectedmagvalue(:,2))
xlabel(" Mag-x data(Gauss)")
ylabel(" Mag-y data(Gauss)")
grid on
hold on;
plot(circleimumagx,circleimumagy,"red")
legend('Hard Iron Corrected Data','Original Data ')
title('Original Magnatometer Data VS Hard Iron Corrected Data')
hold off;

%Hard Iron
figure;
plot(hardcorrectedmagvalue(:,1),hardcorrectedmagvalue(:,2))
xlabel(" Mag-x data(Gauss)")
ylabel(" Mag-y data(Gauss)")
grid on
hold on;
plot(0,0,'r*')
title('Hard Iron Corrected Data')
legend('Hard Iron Corrected Data','Origin')
hold off;
%%
%Soft Iron
figure;
plot(softcorrectmagx,softcorrectmagy,"green")
hold on;
plotellipse(z1,a1,b1,al1)
xlabel("soft-iron corrected mag-x(Gauss)")
ylabel("soft iron corrected mag-y(Gauss)")
title("soft iron corrected")
grid on
hold off;
%%
%All Togeether
figure;
plot(hardcorrectedmagvalue(:,1),hardcorrectedmagvalue(:,2))
xlabel(" Mag-x data(Gauss)")
ylabel(" Mag-y data(Gauss)")
grid on
hold on;
plotellipse(z1,a1,b1,al1,'green')
plot(circleimumagx,circleimumagy,"red")
legend('Hard Iron Corrected Data','Soft Iron Corrected Data ', 'Original Mag Data')
title('Original Magnatometer Data VS Hard Iron Corrected Data')
hold off;


%%
data_driving_imu = readtable('/MATLAB Drive/boston_mini_tour/tourimu.csv');
data_driving_gps = readtable('/MATLAB Drive/boston_mini_tour/tourgps.csv');
data_driving_imu.x_Header_stamp_secs = data_driving_imu.header_stamp_secs - min(data_driving_imu.header_stamp_secs);
data_driving_gps.x_Header_stamp_secs = data_driving_gps.Header_stamp_secs - min(data_driving_gps.Header_stamp_secs);

%% Calculate the yaw angle from the magnetometer calibration
yawangle = atan2(((data_driving_imu.mag_field_magnetic_field_y - offsety)/gamma),...
                    data_driving_imu.mag_field_magnetic_field_x - offsetx);
yaw_unwrapped = unwrap(yawangle);
shifted_yaw_angle = yaw_unwrapped - min(yaw_unwrapped);
yawangle_degree = rad2deg(shifted_yaw_angle);

%Using Lowpass Filter for magnetometer readings
yawangle_filtered = lowpass(yawangle_degree, 0.01, 40);

% create a figure with two subplots side by side
figure;
subplot(2,1,1) % first subplot for raw yaw angle data
plot(data_driving_imu.x_Header_stamp_secs, yawangle_degree,'r')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Raw Yaw Angle Plot of Magnetometer with Time")
grid on

subplot(2,1,2) % second subplot for filtered yaw angle data
plot(data_driving_imu.x_Header_stamp_secs, yawangle_filtered,'g')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Filtered Yaw Angle Plot of Magnetometer with Time")
grid on

%Yaw from IMU 
orix = data_driving_imu.imu_orientation_x - mean(data_driving_imu.imu_orientation_x);
oriy = data_driving_imu.imu_orientation_y - mean(data_driving_imu.imu_orientation_y);
oriz = data_driving_imu.imu_orientation_z - mean(data_driving_imu.imu_orientation_z);
oriw = data_driving_imu.imu_orientation_w - mean(data_driving_imu.imu_orientation_w);

% Combine quaternions into a single Nx4 matrix
quaternions = [oriw orix oriy oriz];

% Convert quaternions to Euler angles
eulerAngles = quat2eul(quaternions);


Yaw_from_imu = unwrap(170+rad2deg(eulerAngles(:,1)));





%%
%Calculate yaw angle for gyro

yawangle_vel = (cumtrapz(data_driving_imu.x_Header_stamp_secs,data_driving_imu.imu_angular_velocity_z));
yawangle_degree_vel = 400+rad2deg(yawangle_vel);

yawangle_filter_vel = highpass(yawangle_degree_vel, 0.1, 40);
added_signal = yawangle_filtered + yawangle_filter_vel; % Complimentary signal

figure;
hold on
plot(data_driving_imu.x_Header_stamp_secs,yawangle_degree_vel)
plot(data_driving_imu.x_Header_stamp_secs,yawangle_degree)
plot(data_driving_imu.x_Header_stamp_secs, added_signal)
plot(data_driving_imu.x_Header_stamp_secs, -Yaw_from_imu)

xlabel("Time(sec)")
ylabel("Yaw angle(degree)")
title("Yaw angle plot of gyroscope with time")
legend("Yaw from Gyro", "Yaw from Magnetometer","Complimentary signal","Yaw from IMU")
grid on
hold off


%LP vs HP vs CP
figure;
subplot(2,2,1) % first subplot for complementary filtered signal (hp+lw)
plot(data_driving_imu.x_Header_stamp_secs, added_signal,'r')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Complementary Filtered Signal")
grid on

subplot(2,2,2) % second subplot for high pass filter (gyro)
plot(data_driving_imu.x_Header_stamp_secs, yawangle_filter_vel,'b')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("High Pass Filtered Signal")
grid on

subplot(2,2,3) % third subplot for low pass filter (magnetometer)
plot(data_driving_imu.x_Header_stamp_secs, yawangle_filtered)
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Low Pass Filtered Signal")
grid on

%comparing YAW from 4 sources 
yawangle_filter_vel = highpass(yawangle_degree_vel, 0.1, 40);
added_signal = yawangle_filtered + yawangle_filter_vel; % Complimentary signal

sgtitle("CP vs HP vs LP") % title for the figure

%comparing YAW from 4 sources  
yawangle_filter_vel = highpass(yawangle_degree_vel, 0.1, 40);
added_signal = yawangle_filtered + yawangle_filter_vel; % Complimentary signal
% create a figure with four subplots in a 2 x 2 grid
figure;
subplot(2,2,1) % first subplot for complementary filtered signal (hp+lw)
plot(data_driving_imu.x_Header_stamp_secs, added_signal,'r')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Complimentary signal(HP+LP)")
grid on

subplot(2,2,2) % second subplot for yaw from IMU
plot(data_driving_imu.x_Header_stamp_secs, -Yaw_from_imu, 'g')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Yaw from IMU(Raw)")
grid on

subplot(2,2,3) % third subplot for low pass filter (magnetometer)
plot(data_driving_imu.x_Header_stamp_secs, yawangle_filtered)
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Yaw from Magnetometer(LP filtered)")
grid on

subplot(2,2,4) % fourth subplot for high pass filter (gyro)
plot(data_driving_imu.x_Header_stamp_secs, yawangle_filter_vel,'b')
xlabel("Time (sec)")
ylabel("Magnitude Yaw angle (degree)")
title("Yaw from Gyro(HP filtered)")
grid on



%Lab4 part-2
%Calculating velocity from linear acceleration
init_linear_vel = data_driving_imu.imu_linear_acceleration_x;
linear_vel = cumtrapz(data_driving_imu.x_Header_stamp_secs,init_linear_vel);

figure;
plot(data_driving_imu.x_Header_stamp_secs,linear_vel)
hold on
%plot(data_driving_imu.x_Header_stamp_secs,data_driving_imu.x_IMU_linear_acceleration_x)
xlabel("Time(s)")
ylabel("Linear Velocity(m/s)")
title("Integrated Velocity Plot")
grid on

%%
%Calculating Velocity from gps plot
len1 = length(data_driving_gps.UTM_easting);
for i = 1: len1-1
    square_difference1 = (data_driving_gps.UTM_easting(i+1,:)-data_driving_gps.UTM_easting(i,:))^2;
    square_difference2 = (data_driving_gps.UTM_northing(i+1,:)-data_driving_gps.UTM_northing(i,:))^2;
    distance = sqrt(square_difference1 + square_difference2);
    vel_gps(i) = distance;
end

gps_real = vel_gps';
gps_vel_temp = gps_real;
gps_real(end+1) = 1;

figure;
plot(data_driving_gps.x_Header_stamp_secs,gps_real)
xlabel('Time(s)')
ylabel('Velocity from GPS data(m/s)')
title("Velocity Calculated from GPS data")
grid on


%%
%Removing negative values in acceleration
accelerationx = data_driving_imu.imu_linear_acceleration_x;

% Remove the mean of the entire acceleration data
accelerationx = accelerationx - mean(accelerationx);

% Subtract the mean of each segment of the acceleration data
accelerationx(1:2680) = accelerationx(1:2680) - mean(accelerationx(1:2680));
%accelerationx(7280:8960) = accelerationx(7280:8960) - mean(accelerationx(7280:8960));
accelerationx(9080:14080) = accelerationx(9080:14080) - mean(accelerationx(9080:14080));
accelerationx(15040:16120) = accelerationx(15040:16120) - mean(accelerationx(15040:16120));
%accelerationx(17000:39920) = accelerationx(17000:39920) - mean(accelerationx(16280:45680));
accelerationx(25840:27320) = accelerationx(25840:27320) - mean(accelerationx(25840:27320));
accelerationx(29800:31360) = accelerationx(29800:31360) - mean(accelerationx(29800:31360));
accelerationx(36000:37600) = accelerationx(36000:37600) - mean(accelerationx(36000:37600));
accelerationx(40440:42440) = accelerationx(40440:42440) - mean(accelerationx(40440:42440));
accelerationx(46160:46960) = accelerationx(46160:46960) - mean(accelerationx(46160:46960));
accelerationx(49120:51600) = accelerationx(49120:51600) - mean(accelerationx(49120:51600));
accelerationx(52360:53720) = accelerationx(52360:53720) + mean(accelerationx(52360:53720));
accelerationx(53160:55840) = accelerationx(53160:55840) - mean(accelerationx(53160:55840));
%accelerationx(64600:66400) = accelerationx(64600:66400) - mean(accelerationx(64600:66400));

corrected_vel = cumtrapz(data_driving_imu.x_Header_stamp_secs, accelerationx);

%% 
%comparison of forward velocity before and correction 
figure;
plot(data_driving_imu.x_Header_stamp_secs,linear_vel);
hold on
plot(data_driving_imu.x_Header_stamp_secs,corrected_vel)
legend('Initial velocity','Corrected Velocity')
xlabel('Time(s)')
ylabel('Linear Velocity(m/s)')
title("Comparison of forward velocity before and correction from acceleration")
grid on
hold off

%Comparison between forward velocity from acceleration and GPS data 
figure;
hold on
plot(data_driving_imu.x_Header_stamp_secs,corrected_vel)
plot(data_driving_gps.x_Header_stamp_secs,gps_real)
legend('Corrected Velocity','Velocity from GPS data')
xlabel('Time(s)')
ylabel('Linear Velocity(m/s)')
title("Velocity calculated from accelaration and gps data")
grid on
hold off


%Lab4 part-3
%Dead Reckoning
output = (data_driving_imu.imu_angular_velocity_z - mean(data_driving_imu.imu_angular_velocity_z )).*corrected_vel;

acceleration_y = data_driving_imu.imu_linear_acceleration_y - mean(data_driving_imu.imu_linear_acceleration_y);

figure;
plot(data_driving_imu.x_Header_stamp_secs,output,'g');
hold on
plot(data_driving_imu.x_Header_stamp_secs,acceleration_y,'r')
legend('Multiplied result','Linear Acceleration')
xlabel('Time(s)')
ylabel('Acceleration(m/s^2)')
title('Multiplied result vs linear acceleration')
grid on
hold off
%% 
xcordinate = corrected_vel.*(-cos(deg2rad(added_signal)));
ycordinate = corrected_vel.*(sin(deg2rad(added_signal)));
xdisp = cumtrapz(data_driving_imu.x_Header_stamp_secs,xcordinate);
ydisp = cumtrapz(data_driving_imu.x_Header_stamp_secs,ycordinate);

theta = -100;
rot = [cos(theta), sin(theta); -sin(theta), cos(theta)];

new_cordinate = cat(2,xdisp,ydisp);
tempnewdisp = rot*new_cordinate';
newdisp = tempnewdisp';

newxdisp = newdisp(:,1);
newydisp = (-1)*newdisp(:,2);

figure;
hold on;

% Shift GPS plot to zero
gps_shifted_x = data_driving_gps.UTM_easting - min(data_driving_gps.UTM_easting);
gps_shifted_y = data_driving_gps.UTM_northing - min(data_driving_gps.UTM_northing);
newxdisp = newxdisp*0.35;
newydisp = newydisp*0.35;
plot(gps_shifted_x-328-120, gps_shifted_y-263);
plot(newxdisp, (newydisp)+147); % IMU part

xlabel('Displacement in X(m)')
ylabel('Displacement in Y(m)')
title('Displacement using GPS and IMU')
grid on
legend('GPS', 'IMU');

hold off;


%%
mydoubledot = acceleration_y - mean(acceleration_y);
for i = 1:size(corrected_vel)
    if corrected_vel(i) ~= 0
        xc(i) = ((mydoubledot(i) - output(i))./corrected_vel(i));
    end
end
disp(mean(xc))

%%
function [z, a, b, alpha] = fitellipse(x, varargin)

narginchk(1, 5)
% Default parameters
params.fNonlinear = true;
        params.constraint = 'bookstein';
params.maxits     = 200;
params.tol        = 1e-5;
% Parse inputs
[x, params] = parseinputs(x, params, varargin{:});
% Constraints are Euclidean-invariant, so improve conditioning by removing
% centroid
centro = mean(x, 2);
x        = x - repmat(centro, 1, size(x, 2));
% Obtain a linear estimate
switch params.constraint
    % Bookstein constraint : lambda_1^2 + lambda_2^2 = 1
    case 'bookstein'
        [z, a, b, alpha] = fitbookstein(x);
        
    % 'trace' constraint, lambda1 + lambda2 = trace(A) = 1
    case 'trace'
        [z, a, b, alpha] = fitggk(x);
end % switch
% Minimise geometric error using nonlinear least squares if required
if params.fNonlinear
    % Initial conditions
    z0     = z;
    a0     = a;
    b0     = b;
    alpha0 = alpha;
    
    % Apply the fit
    [z, a, b, alpha, fConverged] = ...
        fitnonlinear(x, z0, a0, b0, alpha0, params);
    
    % Return linear estimate if GN doesn't converge
    if ~fConverged
        warning('fitellipse:FailureToConverge', ...'
            'Gauss-Newton did not converge, returning linear estimate');
        z = z0;
        a = a0;
        b = b0;
        alpha = alpha0;
    end
end
% Add the centroid back on
z = z + centro;
end % fitellipse
% ----END MAIN FUNCTION-----------%
function [z, a, b, alpha] = fitbookstein(x)
%FITBOOKSTEIN   Linear ellipse fit using bookstein constraint
%   lambda_1^2 + lambda_2^2 = 1, where lambda_i are the eigenvalues of A
% Convenience variables
m  = size(x, 2);
x1 = x(1, :)';
x2 = x(2, :)';
% Define the coefficient matrix B, such that we solve the system
% B *[v; w] = 0, with the constraint norm(w) == 1
B = [x1, x2, ones(m, 1), x1.^2, sqrt(2) * x1 .* x2, x2.^2];
% To enforce the constraint, we need to take the QR decomposition
[Q, R] = qr(B);
% Decompose R into blocks
R11 = R(1:3, 1:3);
R12 = R(1:3, 4:6);
R22 = R(4:6, 4:6);
% Solve R22 * w = 0 subject to norm(w) == 1
[U, S, V] = svd(R22);
w = V(:, 3);
% Solve for the remaining variables
v = -R11 \ R12 * w;
% Fill in the quadratic form
A        = zeros(2);
A(1)     = w(1);
A([2 3]) = 1 / sqrt(2) * w(2);
A(4)     = w(3);
bv       = v(1:2);
c        = v(3);
% Find the parameters
[z, a, b, alpha] = conic2parametric(A, bv, c);
end % fitellipse
function [z, a, b, alpha] = fitggk(x)
% Linear least squares with the Euclidean-invariant constraint Trace(A) = 1
% Convenience variables
m  = size(x, 2);
x1 = x(1, :)';
x2 = x(2, :)';
% Coefficient matrix
B = [2 * x1 .* x2, x2.^2 - x1.^2, x1, x2, ones(m, 1)];
v = B \ -x1.^2;
% For clarity, fill in the quadratic form variables
A        = zeros(2);
A(1,1)   = 1 - v(2);
A([2 3]) = v(1);
A(2,2)   = v(2);
bv       = v(3:4);
c        = v(5);
% find parameters
[z, a, b, alpha] = conic2parametric(A, bv, c);
end
function [z, a, b, alpha, fConverged] = fitnonlinear(x, z0, a0, b0, alpha0, params)
% Gauss-Newton least squares ellipse fit minimising geometric distance 
% Get initial rotation matrix
Q0 = [cos(alpha0), -sin(alpha0); sin(alpha0) cos(alpha0)];
m = size(x, 2);
% Get initial phase estimates
phi0 = angle( [1 i] * Q0' * (x - repmat(z0, 1, m)) )';
u = [phi0; alpha0; a0; b0; z0];
% Iterate using Gauss Newton
fConverged = false;
for nIts = 1:params.maxits
    % Find the function and Jacobian
    [f, J] = sys(u);
    
    % Solve for the step and update u
    h = -J \ f;
    u = u + h;
    
    % Check for convergence
    delta = norm(h, inf) / norm(u, inf);
    if delta < params.tol
        fConverged = true;
        break
    end
end
        
alpha = u(end-4);
a     = u(end-3);
b     = u(end-2);
z     = u(end-1:end);
        
    function [f, J] = sys(u)
        % SYS : Define the system of nonlinear equations and Jacobian. Nested
        % function accesses X (but changeth it not)
        % from the FITELLIPSE workspace
        % Tolerance for whether it is a circle
        circTol = 1e-5;
        
        % Unpack parameters from u
        phi   = u(1:end-5);
        alpha = u(end-4);
        a     = u(end-3);
        b     = u(end-2);
        z     = u(end-1:end);
        
        % If it is a circle, the Jacobian will be singular, and the
        % Gauss-Newton step won't work. 
        %TODO: This can be fixed by switching to a Levenberg-Marquardt
        %solver
        if abs(a - b) / (a + b) < circTol
            warning('fitellipse:CircleFound', ...
                'Ellipse is near-circular - nonlinear fit may not succeed')
        end
        
        % Convenience trig variables
        c = cos(phi);
        s = sin(phi);
        ca = cos(alpha);
        sa = sin(alpha);
        
        % Rotation matrices
        Q    = [ca, -sa; sa, ca];
        Qdot = [-sa, -ca; ca, -sa];
        
        % Preallocate function and Jacobian variables
        f = zeros(2 * m, 1);
        J = zeros(2 * m, m + 5);
        for i = 1:m
            rows = (2*i-1):(2*i);
            % Equation system - vector difference between point on ellipse
            % and data point
            f((2*i-1):(2*i)) = x(:, i) - z - Q * [a * cos(phi(i)); b * sin(phi(i))];
            
            % Jacobian
            J(rows, i) = -Q * [-a * s(i); b * c(i)];
            J(rows, (end-4:end)) = ...
                [-Qdot*[a*c(i); b*s(i)], -Q*[c(i); 0], -Q*[0; s(i)], [-1 0; 0 -1]];
        end
    end
end % fitnonlinear
function [z, a, b, alpha] = conic2parametric(A, bv, c)
% Diagonalise A - find Q, D such at A = Q' * D * Q
[Q, D] = eig(A);
Q = Q';
% If the determinant < 0, it's not an ellipse
if prod(diag(D)) <= 0 
    error('fitellipse:NotEllipse', 'Linear fit did not produce an ellipse');
end
% We have b_h' = 2 * t' * A + b'
t = -0.5 * (A \ bv);
c_h = t' * A * t + bv' * t + c;
z = t;
a = sqrt(-c_h / D(1,1));
b = sqrt(-c_h / D(2,2));
alpha = atan2(Q(1,2), Q(1,1));
end % conic2parametric
function [x, params] = parseinputs(x, params, varargin)
% PARSEINPUTS put x in the correct form, and parse user parameters
% CHECK x
% Make sure x is 2xN where N > 3
if size(x, 2) == 2
    x = x'; 
end
if size(x, 1) ~= 2
    error('fitellipse:InvalidDimension', ...
        'Input matrix must be two dimensional')
end
if size(x, 2) < 6
    error('fitellipse:InsufficientPoints', ...
        'At least 6 points required to compute fit')
end
% Determine whether we are solving for geometric (nonlinear) or algebraic
% (linear) distance
if ~isempty(varargin) && strncmpi(varargin{1}, 'linear', length(varargin{1}))
    params.fNonlinear = false;
    varargin(1)       = [];
else
    params.fNonlinear = true;
end
% Parse property/value pairs
if rem(length(varargin), 2) ~= 0
    error('fitellipse:InvalidInputArguments', ...
        'Additional arguments must take the form of Property/Value pairs')
end
% Cell array of valid property names
properties = {'constraint', 'maxits', 'tol'};
while length(varargin) ~= 0
    % Pop pair off varargin
    property      = varargin{1};
    value         = varargin{2};
    varargin(1:2) = [];
    
    % If the property has been supplied in a shortened form, lengthen it
    iProperty = find(strncmpi(property, properties, length(property)));
    if isempty(iProperty)
        error('fitellipse:UnknownProperty', 'Unknown Property');
    elseif length(iProperty) > 1
        error('fitellipse:AmbiguousProperty', ...
            'Supplied shortened property name is ambiguous');
    end
    
    % Expand property to its full name
    property = properties{iProperty};
    
    % Check for irrelevant property
    if ~params.fNonlinear && ismember(property, {'maxits', 'tol'})
        warning('fitellipse:IrrelevantProperty', ...
            'Supplied property has no effect on linear estimate, ignoring');
        continue
    end
        
    % Check supplied property value
    switch property
        case 'maxits'
            if ~isnumeric(value) || value <= 0
                error('fitcircle:InvalidMaxits', ...
                    'maxits must be an integer greater than 0')
            end
            params.maxits = value;
        case 'tol'
            if ~isnumeric(value) || value <= 0
                error('fitcircle:InvalidTol', ...
                    'tol must be a positive real number')
            end
            params.tol = value;
        case 'constraint'
            switch lower(value)
                case 'bookstein'
                    params.constraint = 'bookstein';
                case 'trace'
                    params.constraint = 'trace';
                otherwise
                    error('fitellipse:InvalidConstraint', ...
                        'Invalid constraint specified')
            end
    end % switch property
end % while
end % parseinputs
%%
function varargout = plotellipse(varargin)
%PLOTELLIPSE   Plot parametrically specified ellipse
%
%   PLOTELLIPSE(Z, A, B, ALPHA) Plots the ellipse specified by Z, A, B,
%       ALPHA (as returned by FITELLIPSE)
%
%       A, B are positive scalars, Z a 2x1 column vector, and
%       ALPHA a rotation angle, such that the equation of the ellipse is:
%           X = Z + Q(ALPHA) * [A * cos(phi); B * sin(phi)]
%       where Q(ALPHA) is the rotation matrix
%           Q(ALPHA) = [cos(ALPHA) -sin(ALPHA);
%                       sin(AlPHA) cos(ALPHA)]
%
%   PLOTELLIPSE(..., LineSpec) passes the LineSpec string to the plot
%       command (e.g. 'r--')
%
%   PLOTELLIPSE(Hax, ...) plots into the axes specified by the axes handle
%       Hax
%   
%   H = PLOTELLIPSE(...) returns a handle to the created lineseries object
%       created by the plot command
%   
%   Example:
%       % Ellipse centred at 10,10, with semiaxes 5 and 3, rotated by pi/4
%       a = 5;
%       b = 3;
%       z = [10; 10]
%       alpha = pi/4;
%       plotellipse(z, a, b, alpha)
%
%   See also FITELLIPSE
% Copyright Richard Brown. This code can be freely reused and modified so
% long as it retains this copyright clause
error(nargchk(4, 6, nargin, 'struct'));
error(nargchk(0, 1, nargout, 'struct'));
% Parse and check inputs
if ishandle(varargin{1})
    hAx = varargin{1};
    varargin(1) = [];
else
    hAx = gca();
end
% Ellipse centre
z = varargin{1};
z = z(:); 
if length(z) ~= 2
    error('plotellipse:InvalidCentre', ...
        'Ellipse center must be a 2 element column vector');
end
a = varargin{2};
b = varargin{3};
if ~isscalar(a) || ~isscalar(b) || a < 0 || b < 0
    error('plotellipse:InvalidAxes', ...
        'A, B must be real, positive scalars');
end
alpha = varargin{4};
if ~isscalar(alpha)
    error('plotellipse:InvalidConstant', ...
        'Rotation angle alpha must be a real scalar, in radians');
end
varargin(1:4) = [];
% See if a linespec is supplied
if ~isempty(varargin)
    linespec = varargin{1};
else
    linespec = '';
end
% form the parameter vector
npts = 100;
t = linspace(0, 2*pi, npts);
% Rotation matrix
Q = [cos(alpha), -sin(alpha); sin(alpha) cos(alpha)];
% Ellipse points
X = Q * [a * cos(t); b * sin(t)] + repmat(z, 1, npts);
% The actual plotting one-liner
h = plot(hAx, X(1,:), X(2,:), linespec);
% Return the handle if asked for
if nargout == 1
    varargout = {h};
end
end