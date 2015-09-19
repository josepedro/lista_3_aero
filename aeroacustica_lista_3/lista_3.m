clear('all');
close all;

% Lista de Exercícios 3

disp('Questão 1 ----------------------');
velocidades = open('velocidades.mat');
velocidades_x = velocidades.vel_x(:,:,1);
velocidades_y = velocidades.vel_y(:,:,1);
rho = 1.2; % kg/m^3
delta_x = 0.003; % m
posicao_ouvinte = [15 15 15]; % m

pressao_acustica = calcular_pressao(rho, delta_x, velocidades_x, velocidades_y, posicao_ouvinte, velocidades.vel_x);

valor_referencia = 2*10^-5;
nivel_pressao_sonora_dB = 20*log((pressao_acustica+valor_referencia)/valor_referencia);
