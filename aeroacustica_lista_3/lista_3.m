clear('all');
close all;

% Lista de Exercícios 3

% Plotando as velocidades em 3D
velocidades = open('velocidades.mat');
velocidades_x = velocidades.vel_x;
velocidades_y = velocidades.vel_y;
velocidades_z = velocidades.vel_z;
rho = 1.2; % kg/m^3
delta_x = 0.003;

figure;
hold on;
grid on;
grid minor;
plot3(velocidades_x(:,1), velocidades_x(:,2), velocidades_x(:,3), 'b');
plot3(velocidades_y(:,1), velocidades_y(:,2), velocidades_y(:,3), 'r');
plot3(velocidades_z(:,1), velocidades_z(:,2), velocidades_z(:,3), 'g');

% Obs: Não há nenhuma velocidade em Z

% Multiplicando as 3 matrizes, construindo vivj
disp('Multiplicando as matrizes');
% Para velocidades em x
magnitude_velocidade_x = velocidades_x.^2;
% Para velocidades em y
magnitude_velocidade_y = velocidades_y.^2;

% Calculando o rho*vi*vj
disp('Calculando o rho*vi*vj');
rho_vi_vj = rho*(sqrt(magnitude_velocidade_x + magnitude_velocidade_y));

% Dividindo pela magnitude do espaco e 4*pi (|x|)
matriz_x = [1:100]*delta_x;
matriz_y = [1:95]*delta_x;
matriz_z = [1:100]*delta_x;

disp('Dividindo pela magnitude do espaco e 4*pi (|x|)');
tamanhos = 	size(rho_vi_vj);
i = 0;
matriz_distancia_i_j_k = {};
for	x_i = 1:tamanhos(1)
	for	x_j = 1:tamanhos(2)
		for x_k = 1:tamanhos(3)
			disp('x_k');
			matriz_distancia{x_i*x_j*x_k} = [x_i - 1, x_j - 1, x_k - 1]*0.03;
			i = i + 1;
			disp(i);
		end
	end
end

for ponto = 1:tamanhos(1)*tamanhos(2)*tamanhos(3)
	rho_vi_vj	
end

%rho_vi_vj = rho_vi_vj/4*pi*(sqrt(x_i^2 + x_j^2 + x_k^2));

% Calculando o laplaciano para depois integrar
disp('Calculando o laplaciano para depois integrar');
%laplaciano_rho_vi_vj = 	diff(diff(rho_vi_vj));

% Calculando a pressao final
disp('Calculando a pressao final');
%pressao = trapz(laplaciano_rho_vi_vj, ndims(laplaciano_rho_vi_vj));

%pressao(15,15,15)
