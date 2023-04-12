%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%get data from "Z" potential energylandscape
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%define simulation and model parameters
L = 4;            %number of states
lag = 10;         %lag time between state observations
samples = 10^6;   %number of sample points
dt = 0.01;        %time step
bta = 1;          %inverse temperature

%define Z potential
V = @(x,y) (x.^4+y.^4)/(20480) ...
           - 3*exp(-0.01*(x+5).^2-0.2*(y+5).^2) ...
           - 3*exp(-0.01*(x-5).^2-0.2*(y-5).^2) ...
           + 5*exp(-0.2*(x+3*(y-3)).^2)./(1+exp(-x-3)) ...
           + 5*exp(-0.2*(x+3*(y+3)).^2)./(1+exp(x-3)) ...
           + 3*exp(-0.01*(x.^2+y.^2));

%compute partial derivatives of Z potential
syms x y; dVx = matlabFunction(diff(V,x)); dVy = matlabFunction(diff(V,y));

%compute gradient of V
dV = @(x) [dVx(x(1),x(2)) dVy(x(1),x(2))];

%define collective variables
CV1 = @(x) ceil((L/30)*max(min(x(1)+15,30),10^(-10)));
CV2 = @(x) ceil((L/20)*max(min(x(2)+10,20),10^(-10)));

%simulate long trajectory
X = zeros(samples,2); data = zeros(samples,2); x = [-8 -5]; 
for sample=1:samples
    for t=1:lag
        x = x - dV(x)*dt - sqrt(2*dt/bta)*normrnd(0,1,[1 2]);
    end
    X(sample,:) = x; data(sample,:) = [CV1(x) CV2(x)];
end

%save Matlab workspace
save MZ_traj.mat X data V L