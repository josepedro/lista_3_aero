clear('all');
close all;

% Lista de Exercícios 3

% Plotando as velocidades em 3D
velocidades = open('velocidades.mat');
velocidades_x = velocidades.vel_x;
velocidades_y = velocidades.vel_y;
velocidades_z = velocidades.vel_z;

figure;
hold on;
grid on;
grid minor;
plot3(velocidades_x(:,1), velocidades_x(:,2), velocidades_x(:,3), 'b');
plot3(velocidades_y(:,1), velocidades_y(:,2), velocidades_y(:,3), 'r');
plot3(velocidades_z(:,1), velocidades_z(:,2), velocidades_z(:,3), 'g');

% Obs: Não há nenhuma velocidade em Z

% Construindo matriz espacial de 3 dimensões


% Realizando o calculo da velocidade X
pressao_sonora_x = 

sum(velocidades_z(:,1)) + sum(velocidades_z(:,2)) + sum(velocidades_z(:,3))