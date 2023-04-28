%% Inizializzazione Workspace
clear all
clc

%% Inizializzazione parametri

g = 9.81;           % accelerazione gravitazionale 
m = 3.95;           % massa del drone
K_t = 0;            % coefficiente d'attrito lineare
K_r = 0;            % coefficiente d'attrito angolare
J_x = 0.363;        % inerzia lungo X_B
J_y = 0.363;        % inerzia lungo Y_B
J_z = 0.651;        % inerzia lungo Z_B
l = 0.45;           % lunghezza braccio
C_L = 3.13*10e-5;   % coefficiente di lift
C_D = 7.5*10e-7;    % coefficiente di drag

%% Tensore di inerzia

J= [J_x  0    0;
    0    J_y  0;    
    0    0    J_z];

%% Vettore che contiene gli angoli roll-pitch-yaw

syms phi theta psi  real

eta=[phi;  
    theta;
    psi];

%% Posizione del Frame rispetto alla terna Re

syms X_F Y_F Z_F real

P_F=[X_F;  
    Y_F;
    Z_F];

%% Velocità angolare del corpo

syms p q r real

w= [p;     
    q;
    r];

%% Ingresso fornito dai 4 motori

syms u1 u2 u3 u4 real

u=[ u1;    
    u2;
    u3;
    u4];

%% Guasto additivo in ingresso(forza)

syms xF_m_B yF_m_B zF_m_B real

deltaF_m_B =[xF_m_B;
             yF_m_B;
             zF_m_B];

%% Forze esterne

syms Fex Fey Fez real

Fe= [Fex;
    Fey;
    Fez];

%% Guasto additivo in ingresso(momento)

syms xM_m_B yM_m_B zM_m_B  t real

deltaM_m_B=[xM_m_B;
            yM_m_B;
            zM_m_B];

%% Forze che serviranno succesivamente

F1=[0 0 0 0;
    0 0 0 0;
    1 1 1 1];

F2=[ 0         l          0         -l;
    -l         0          l          0;
    -(C_D/C_L) (C_D/C_L) -(C_D/C_L) (C_D/C_L) ];

%% Vettori canonici

e1=[1;
    0;
    0];

e2=[0;
    1;
    0];

e3=[0;
    0;
    1];    

%e3T= e3';
%% Matrice di Rotazione

R =[cos(psi)*cos(theta) cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi) sin(phi)*sin(psi)+cos(phi)*cos(psi)*sin(theta);
    cos(theta)*sin(psi) cos(phi)*cos(psi)+sin(phi)*sin(psi)*sin(theta) cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi);
    -sin(theta)         cos(theta)*sin(phi)                            cos(phi)*cos(theta)];

%% Matrice di Trasformazione
T=[1 sin(phi)*tan(theta) cos(phi)*tan(theta);
   0 cos(phi)            -sin(phi);
   0 sin(phi)/cos(theta) cos(phi)/cos(theta)];

%% Def. Pdot
syms xdot ydot zdot real
pfdot=[xdot;
       ydot;
       zdot];
%% Equazioni del modello
Fm= F1*u;
Mm=F2*u;
Fe=0;
deltaF_m_B =0;
deltaM_m_B=0;
% equazioni 
ddPF=(-K_t*pfdot -m*g*e3 +R*(Fm +deltaF_m_B) + Fe)/m;
ddx=ddPF(1)
ddy=ddPF(2)

dw= inv(J)*(-K_r*w -cross(w,(J*w)) + Mm + deltaM_m_B);

deta= T*w;

dPF= diff(ddPF);
PF= diff(dPF);
ZF = e3'*PF ;

%% Controllo 
t = (-1:0.01:1)';
 x=10*cos(t);
 y=10*sin(t);
 plot(x,y)
% derivata della matrice T
%syms phi(t) theta(t)

T1=[1 sin(phi)*tan(theta) cos(phi)*tan(theta);
   0 cos(phi)            -sin(phi);
   0 sin(phi)/cos(theta) cos(phi)/cos(theta)];
%D_T1= diff(T1);

phi_dot=deta(1);
theta_dot=deta(2);
D_TF=[0             sin(phi)*(tan(theta)^2 + 1)*theta_dot + cos(phi)*tan(theta)*phi_dot             cos(phi)*(tan(theta)^2 + 1)*theta_dot - sin(phi)*tan(theta)*phi_dot;
     0                                                                                -sin(phi)*phi_dot                        -cos(phi)*phi_dot;
     0 (cos(phi)*phi_dot)/cos(theta) + (sin(phi)*sin(theta)*theta_dot)/cos(theta)^2 (cos(phi)*sin(theta)*theta_dot)/cos(theta)^2 - (sin(phi)*phi_dot)/cos(theta)];
 

