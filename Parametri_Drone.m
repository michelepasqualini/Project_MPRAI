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

%% Forze che serviranno succesivamente

F1=[0 0 0 0;
    0 0 0 0;
    1 1 1 1];

F2=[ 0         l          0         -l;
    -l         0          l          0;
    -(C_D/C_L) (C_D/C_L) -(C_D/C_L) (C_D/C_L) ];
 
F=[  1          1           1           1;
     0          l           0          -l;
    -l          0           l           0;
    -(C_D/C_L) (C_D/C_L) -(C_D/C_L) (C_D/C_L) ];
Finv=inv(F);

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

e3T= e3';

%% aeta0 aeta1 az0 az1

a= poly([-3 -3]);
az0=a(3)
az1=a(2)

b=poly([-30 -5]);
ab0=b(3);
ab1=b(2);

c=poly([-30 -5]);
ac0=c(3);
ac1=c(2);

d=poly([-3 -4]);
ad0=d(3);
ad1=d(2);

aeta0=[ab0 0 0;
       0   ac0 0;
       0   0   ad0]
aeta1=[ab1 0 0;
       0   ac1 0;
       0    0   ad1]

%% Outer loop
x= poly([-1.5 -1.5]);
ax0=x(3)
ax1=x(2)

y= poly([-1.5 -1.5]);
ay0=y(3)
ay1=y(2)

%% Matrice L

l_1= poly([-2 -1 -3])
l0=l_1(4)
l1=l_1(3)
l2=l_1(2)
L1=[l0 0 0;
    0 l1 0;
    0 0 l2; ]

l_2=poly([-2 -3 -1])
l_0=l_2(4)
l_1=l_2(3)
l_2=l_2(2)
L2=[l_0 0 0;
    0 l_1 0;
    0 0 l_2]
save Parametri_Drone