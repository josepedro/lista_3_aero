clear('all');
close all;

% Lista de Exercícios 3

disp('Questão 1 ----------------------');
velocidades = open('velocidades.mat');
velocidades_x = velocidades.vel_x(:,:,1);
velocidades_y = velocidades.vel_y(:,:,1);
rho = 1.2; % kg/m^3
delta_x = 0.003; % m
coordenadas_x = [15 15]; % m



pressao_acustica = calcular_pressao(rho, delta_x, velocidades_x, velocidades_y, coordenadas_x);

resposta = ['Valor de Pressão Acústica: ', num2str(pressao_acustica, '%10.5e'), ...
' 	N/m^2'];
disp(resposta);

disp('Questão 2 ----------------------');
% Plotando mapa de superfície de velocidade absoluta
velocidades_absolutas = sqrt(velocidades_x.^2 + velocidades_y.^2);
[x,y] = meshgrid([0:99]*0.003);
x = x(:, 1:95);
y = y(:, 1:95);
figure;
surf(velocidades_absolutas);
vorticidade = curl(velocidades_x, velocidades_y);
figure;
surf(x, y, vorticidade);
resposta = ['O valor da dimensao característica é 0.0630 metros ou 63 mm', ...
' pois a turbulencia possui um centro definido com esse diâmetro característico.'];
disp(resposta);	

disp('Questão 3 ----------------------');
% Plotando grafico de pressao por velocidades atraves da equacao 1
pressao_velocidades_1(1:10) = 0;
pressao_velocidades_2(1:10) = 0;
for divisao = 1:10
	velocidade_divisao = 10^divisao;
	pressao_velocidades_1(divisao) = calcular_pressao(rho, delta_x, velocidades_x/velocidade_divisao ...
	, velocidades_y/velocidade_divisao, coordenadas_x);
	pressao_velocidades_2(divisao) = 
end
figure;

plot(pressao_velocidades_1);


% Plotando mapa de superfície de velocidade absoluta
%figure;
%hold on;
%grid on;
%grid minor;
%plot3(velocidades_x(:,1), velocidades_x(:,2), velocidades_x(:,3), 'b');
%plot3(velocidades_y(:,1), velocidades_y(:,2), velocidades_y(:,3), 'r');
%plot3(velocidades_z(:,1), velocidades_z(:,2), velocidades_z(:,3), 'g');
