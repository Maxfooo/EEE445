% EEE445 Equation list

%% Constants
mu0 = 4*pi*1e-7;
eps0 = 8.854e-12;
sigCu = 5.813e7;
eta0 = 377;

%% General Equations

% sheet resistance
Rs = inline('sqrt(2*pi*f*mu/(2*sigma))','f','mu','sigma');

% Dielectric attenuation/loss/alpha
alpha_di = inline('k^2*lossTan/(2*beta)','k','lossTan','beta');

% Wave impedance
eta = inline('sqrt(mu/eps)','mu','eps');

% Neper/meter to dB/meter
n2dB = inline('20*alpha/log(10)','alpha');

%% Circular Waveguide

% circular waveguide conductor attenuation/loss/alpha
alphaC_circ = inline('(Rs*(kc^2+k^2/(p^2-1)))/(a*k*eta*beta)','Rs','kc','k','p','a','eta','beta');

% Cutoff wave number
kc_circ = inline('p/a', 'p', 'a');

% wave number
k0_circ = inline('2*pi*f*sqrt(mu*eps)','f','mu','eps');

% Cutoff Frequency
fc_circP = inline('p/(2*pi*a*sqrt(mu*eps))','p','a','mu','eps');
fc_circK = inline('k/(2*pi*sqrt(mu*eps))','k','mu','eps');

%% Microstrip line

A = inline('z0/60*sqrt((epsr+1)/2)+(epsr-1)/(epsr+1)*(0.23+0.11/epsr)','z0','epsr');
B = inline('377*pi/(2*z0*sqrt(epsr))','z0','epsr');
W_over_d1 = inline('8*exp(A)/(exp(2*A)-2)','A');
W_over_d2 = inline('2/pi*(B-1-log(2*B-1)+(epsr-1)/(2*epsr)*(log(B-1)+0.39-0.61/epsr))','B','epsr');

eps_e = inline('(epsr+1)/2+(epsr-1)/2*(1+12*d/W)^(-1/2)','epsr','d','W');


%% Single Shunt Stub Tuning

% tangent of electrical length
teLength = inline('tan(beta*d)','beta','d');

% tangent of electrical length used for matching given impedances
% If Rl == Z0
telMatch = inline('-Xl/(2*Z0)','Xl','Z0');
% else
telMatchPlus = inline('(Xl+sqrt(Rl*((Z0-Rl)^2+Xl^2)/Z0))/(Rl-Z0)','Rl','Xl','Z0');
telMatchMinus = inline('(Xl-sqrt(Rl*((Z0-Rl)^2+Xl^2)/Z0))/(Rl-Z0)','Rl','Xl','Z0');

% Distance D from load (to connect the shunt stub) in fraction of lambda
shuntDPlus = inline('1/(2*pi)*atan(t)','t');
shuntDMinus = inline('1/(2*pi)*(pi+atan(t))','t');

% B -> Susceptance at electrical length t away 
% Short circuit
shuntBsc = inline('(Rl^2*t-(Z0-Xl*t)*(Xl+Z0*t))/(Z0*(Rl^2+(Xl+Z0*t)^2))','Rl','Xl','Z0','t');

% length of shunt stub line in fraction of lambda
shuntL = inline('1/(2*pi)*atan(Y0/B)','Y0','B');

Z0 = 50;
Y0 = 1/Z0;
Zl = Z0*(1-i*0.6);
Rl = real(Zl);
Xl = imag(Zl);
t = telMatch(Xl,Z0)
sDp = shuntDPlus(t)
B = shuntBsc(Rl,Xl,Z0,t)
l = shuntL(Y0,B)

