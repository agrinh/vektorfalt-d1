%% Exercise 1a
% constants
G = 6.673E-11;  % the gravitational constant
d = 7E8;  % distance between stars
ms = 1.989E30;  % sun mass
m1 = 1;  % ammount of sunmasses of star 1
m2 = 0.4;  % ammount of sunmasses of star 2
levels = -[5E11 0.01*exp(linspace(0, 42, 70))];  % levels for contours


% calculate position of stars
% - place the starts along the x axis and select m1 to the left and m2 to the
%   right
d1 = d / (1 + m1/m2);  % distance from (0, 0) to star 1
d2 = (m1/m2) * d1;  % distance from (0, 0) to star 2
r1 = [-d1 0 0];  % position of star 1
r2 = [d2 0 0];  % position of star 2

% produce xy plane
x = linspace(-1.5*d, 1.5*d, 1e3);
[X, Y] = meshgrid(x, x);

% calculate the potential on the plane
w = angular_velocity(r1, r2, m1*ms, m2*ms, G);
PHI = arrayfun(@(x, y) potential([x y 0], r1, r2, m1*ms, m2*ms, w, G), X, Y);

% plot
figure();
contour(X, Y, PHI, levels);
daspect(ones(1, 3));

%% Exercise 1b
% run 1A first
step = 46;
sub = @(M) M(1:step:end, 1:step:end);
[FX,FY] = gradient(sub(PHI));
hold on;
quiver(sub(X), sub(Y), -5E-4*FX, -5E-4*FY, 1);
hold off;

%% Exercise 2 - setup
J = 2;  % vortex strength
x0 = 10;  % vortex positions at x = +/- x0
colors = ['r', 'g', 'y', 'k', 'm'];  % colors for fieldlines
r_start = [2,  -1;
           4,  -1;
           18, -1;
           20, -1;
           -20,-1];  % start positions for fieldlines
t_span = [0, 500];  % iterations for generating fieldline

% space to plot vortex in
x = linspace(-20, 20, 15);
[X, Y] = meshgrid(x, x);

%% Excercise 2a
% run setup first
[UX, UY] = fluid_velocity_a(X, Y, J, x0);
packed_fluid = repack(@fluid_velocity_a, true);

%% Excercise 2b
% run setup first
[UX, UY] = fluid_velocity_b(X, Y, J, x0);
packed_fluid = repack(@fluid_velocity_b, true);

%% Exercise 2 - plot
% run setup and a part subexercise first
figure();
quiver(X, Y, UX, UY);
hold on;
for i = 1:size(r_start, 1)
    color = colors(1 + mod(i, length(colors)));
    [~, x] = ode15s(@(t, r)packed_fluid(r(1), r(2), J, x0), ...
                    t_span, ...
                    r_start(i, :));
    plot(x(:, 1), x(:, 2), color);
    plot(x(1, 1), x(1, 2), ['o' color], 'MarkerSize', 20);
    plot(x(end, 1), x(end, 2), ['x' color], 'MarkerSize', 20);
end
hold off;
