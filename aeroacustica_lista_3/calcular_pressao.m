%% functionname: function description
function pressao_acustica = calcular_pressao(rho, delta_x, velocidades_x, velocidades_y, coordenadas_x)

	% Calculando o rho*vi*vj
	rho_vi_vj = rho*(sqrt(sum(velocidades_x.^2 + velocidades_y.^2)));
	
	% Dividindo pelo raio
	tamanhos = size(rho_vi_vj);
	for x_i = 1:tamanhos(1)
		for x_j = 1:tamanhos(2)
			%distancia =  sqrt((x_i*0.003)^2 + (x_j*0.003)^2);
			distancia =  sqrt((coordenadas_x(1))^2 + (coordenadas_x(2))^2);
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