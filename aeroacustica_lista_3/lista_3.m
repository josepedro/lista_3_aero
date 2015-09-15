clear('all');
close all;

% Lista de Exercícios 3

disp('Questão 1 ----------------------');
velocidades = open('velocidades.mat');
velocidades_x = velocidades.vel_x;
velocidades_y = velocidades.vel_y;
velocidades_z = velocidades.vel_z;
rho = 1.2; % kg/m^3
delta_x = 0.003;

% Calculando o rho*vi*vj
magnitude_velocidade_x = velocidades_x(:,:,1).^2;
magnitude_velocidade_y = velocidades_y(:,:,1).^2;
rho_vi_vj = rho*(sqrt(sum(magnitude_velocidade_x + magnitude_velocidade_y)));

% Dividindo pelo raio
tamanhos = size(rho_vi_vj);
for x_i = 1:tamanhos(1)
	for x_j = 1:tamanhos(2)
		%distancia =  sqrt((x_i*0.003)^2 + (x_j*0.003)^2);
		distancia =  sqrt((15)^2 + (15)^2);
		rho_vi_vj(x_i, x_j) = rho_vi_vj(x_i, x_j)/4*pi*distancia;
	end
end

% Calculando o laplaciano para depois integrar
rho_vi_vj_a(1:length(rho_vi_vj)) = 0;
% derivando a primeira vez
for n = 1:length(rho_vi_vj_a)-1
	rho_vi_vj_a(n) = (rho_vi_vj(n+1)-rho_vi_vj(n))/delta_x;
end
% derivando a segunda vez
for n = 1:length(rho_vi_vj_a)-2
	rho_vi_vj_a(n) = (rho_vi_vj(n+1)-rho_vi_vj(n))/delta_x;
end
laplaciano_rho_vi_vj = rho_vi_vj_a(1:length(rho_vi_vj)-2);

% Calculando a pressao final
pressao_acustica = trapz(laplaciano_rho_vi_vj);
resposta = ['Valor de Pressão Acústica: ', num2str(pressao_acustica, '%10.5e'), ...
' 	N/m^2'];
disp(resposta);

disp('Questão 2 ----------------------');
% Plotando mapa de superfície de velocidade absoluta
velocidades_x = velocidades_x(:,:,1);
velocidades_y = velocidades_y(:,:,1);
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

% Plotando mapa de superfície de velocidade absoluta
%figure;
%hold on;
%grid on;
%grid minor;
%plot3(velocidades_x(:,1), velocidades_x(:,2), velocidades_x(:,3), 'b');
%plot3(velocidades_y(:,1), velocidades_y(:,2), velocidades_y(:,3), 'r');
%plot3(velocidades_z(:,1), velocidades_z(:,2), velocidades_z(:,3), 'g');
