%% Inizializzazione Workspace


%% Posizione

pfscope=extractTimetable(out.pfscope);
val_rif=extractTimetable(out.Scope_val_rif);
figure()
p1=plot3(pfscope.Data(:,1),pfscope.Data(:,2),pfscope.Data(:,3))

hold on
grid on
p2=plot3(val_rif.Data(:,1),val_rif.Data(:,2),val_rif.Data(:,3))
title('Posizione finale')
xlabel('x [m]')
ylabel('y [m]')
zlabel('z [m]')
set(p1, 'Color', 'red');
set(p2, 'Color', 'black');
set(gcf,'color','w');
legend('segnale ottenuto','segnale riferimento')

%% Velocità

%vpfscope=extractTimetable(out.vfscope);
%figure()
%plot(vpfscope.Data)
%hold on
%title('Velocità finale')
%xlabel('t [s]')
%ylabel('V [m/s]')
%legend('Vx','Vy','Vz')
%% Velocità angolari

%wscope=extractTimetable(out.wscope);
%figure()
%plot(wscope.Data)
%hold on
%title('Velocità angolare w')
%ylabel('w [rad/s]')
%xlabel('t [s]')
%legend('p','q','r')

%% Angoli

%etascope=extractTimetable(out.etascope);
%figure()
%plot(etascope.Data)
%hold on
%title('Eta (Angoli)')
%ylabel('Eta [rad]')
%xlabel('t [s]')
%legend('phi','theta','psi')

%% Errori

% Errore in z
errore_z=extractTimetable(out.errorezfscopesingolo)
figure()
plot(errore_z.Time,errore_z.Data)
hold on
grid on
title('Errore in z')
ylabel('P [m]')
xlabel('t [s]')
legend('errore_z')
set(gcf,'color','w');

% Differenza in x
figure()
p3=plot(pfscope.Time,pfscope.Data(:,1))

hold on
grid on
p4=plot(val_rif.Time,val_rif.Data(:,1))
title('Posizione finale x')
xlabel('t [s]')
ylabel('x [m]')
set(p3, 'Color', 'red');
set(p4, 'Color', 'black');

legend('x','xr')
set(gcf,'color','w');

% Differenza in y
figure()
p5=plot(pfscope.Time,pfscope.Data(:,2))

hold on
grid on
p6=plot(val_rif.Time,val_rif.Data(:,2))
title('Posizione finale y')
xlabel('t [s]')
ylabel('y [m]')
set(p5, 'Color', 'red');
set(p6, 'Color', 'black');

legend('y','yr')
set(gcf,'color','w');
% Errore in Eta

errore_eta=extractTimetable(out.erroreeta)
figure()
plot(errore_eta.Time,errore_eta.Data)
hold on
grid on
title('Errore in Eta')
ylabel('Eta [rad]')
xlabel('t [s]')
legend('phi','theta','psi')
set(gcf,'color','w');

%% Differenza

% Differenza nella posizione z
figure()
p7=plot(pfscope.Time,pfscope.Data(:,3))

hold on
grid on
p8=plot(val_rif.Time,val_rif.Data(:,3))
title('Posizione finale z')
xlabel('t [s]')
ylabel('z [m]')
set(p7, 'Color', 'red');
set(p8, 'Color', 'black');
set(gcf,'color','w');

legend('z','zr')

% Differenza angolo phi

dif_phi=extractTimetable(out.scope_diff_phi)
figure()
v=plot(dif_phi.Time,dif_phi.Data)
hold on
grid on
title('Confronto degli angoli phi e phir')
ylabel('[Rad]')
xlabel('t [s]')
set(v(1), 'Color', 'red');
set(v(2), 'Color', 'black');
legend('phi','phir')
set(gcf,'color','w');

% Differenza angolo theta

dif_theta=extractTimetable(out.scope_diff_theta)
figure()
o=plot(dif_theta.Time,dif_theta.Data)
hold on
grid on
title('Confronto degli angoli theta e thetar')
ylabel('[Rad]')
xlabel('t [s]')
set(o(1), 'Color', 'red');
set(o(2), 'Color', 'black');
legend('theta','thetar')
set(gcf,'color','w');
% Differenza angolo psi

dif_psi=extractTimetable(out.scope_diff_psi)
figure()
h=plot(dif_psi.Time,dif_psi.Data)
hold on
grid on
title('Confronto degli angoli psi e psir')
ylabel('[Rad]')
xlabel('t [s]')
set(h(1), 'Color', 'red');
set(h(2), 'Color', 'black');
legend('psi','psir')
set(gcf,'color','w');

%% Plot della fault detection
fault=extractTimetable(out.Faultscope)
figure()
fault_plot=plot(fault.Time,fault.Data)
hold on
grid on
title('Rilevamento attraverso fault detection')
ylabel('[val]')
xlabel('t [s]')
set(fault_plot(1), 'Color', 'black');
legend('residuo')
set(gcf,'color','w');

%% Plot della ingresso
ingresso=extractTimetable(out.Uscope)
figure()
u_plot=plot(ingresso.Time,ingresso.Data)
hold on
grid on
title('Ingresso')
ylabel('F [N]')
xlabel('t [s]')
set(u_plot(1), 'Color', 'black');
set(u_plot(2), 'Color', 'red');
set(u_plot(3), 'Color', 'blue');
set(u_plot(4), 'Color', 'magenta');
legend('U1','U2','U3','U4')
set(gcf,'color','w');

