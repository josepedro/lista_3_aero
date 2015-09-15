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
laplaciano_rho_vi_vj = 	del2(rho_vi_vj);
%surf(laplaciano_rho_vi_vj)

% Calculando a pressao final
pressao = trapz(laplaciano_rho_vi_vj);


%figure;
%hold on;
%grid on;
%grid minor;
%plot3(velocidades_x(:,1), velocidades_x(:,2), velocidades_x(:,3), 'b');
%plot3(velocidades_y(:,1), velocidades_y(:,2), velocidades_y(:,3), 'r');
%plot3(velocidades_z(:,1), velocidades_z(:,2), velocidades_z(:,3), 'g');
