% Simulation und Berechnung des Frequenzganges (Amplitudengang
% und Phasengang) für die Übertragungsfunktion
% G(s) = k/(T1 * s + 1) .... Verzögerungselement 1. Ordnung

% Systemparameter
k=3;
T1=1;

% Definition der Frequenzachse w in [rad/s]
w=0.1:0.1:500; % lineare Frequenzachse
w=logspace(-2,3,100); % besser logarithmische Frequenzachse

% Berechnung des Real- und Imaginäranteils
ReG = k./(1 + (w.*T1).^2);
ImG = -k.*w.*T1 ./(1 + (w.*T1).^2);
absG = sqrt(ReG.^2+ImG.^2);
phiG = atan2(ImG,ReG);

figure(1);
plot(w,absG);
grid on; zoom on;
xlabel('w [rad/s]');
ylabel('Amplitude');

figure(2);
plot(w,phiG*180/pi);
grid on; zoom on;
xlabel('w [rad/s]');
ylabel('Phase [deg]');

figure(3);
subplot(211);
semilogx(w,20*log10(absG));
grid on; zoom on;
title('Bode Diagramm');
ylabel('Amplitude [dB]');
subplot(212);
semilogx(w,phiG*180/pi);
grid on; zoom on;
ylabel('Phase [deg]');
xlabel('w [rad/s]');

figure(4);
plot(ReG,ImG);
grid on; zoom on;
xlabel('Realteil{G(jw)}');
ylabel('Imaginärteil{G(jw)}');
title('Nyquist-Ortskurve');

figure(5);
polar(phiG,absG);
grid on; zoom on;
xlabel('Realteil{G(jw)}');
ylabel('Imaginärteil{G(jw)}');
title('Nyquist-Ortskurve');

s=tf('s');
sys=tf([k],[T1 1]),

figure(6);
bode(sys,w);
grid on;

figure(7);
nyquist(sys);
grid on;




