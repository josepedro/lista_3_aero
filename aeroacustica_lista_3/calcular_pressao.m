function pressao_acustica = calcular_pressao(rho, delta_x, velocidades_x, ...
	velocidades_y, posicao_ouvinte, matriz_cubica)

	% Calculando o vi*vj
	vi_vj = sqrt(sum(sum(velocidades_x.^2)) + sum(sum(velocidades_y.^2)));
	% Calculando o rho*vi*vj
	rho_vi_vj = rho*vi_vj;

	% Preenchendo a matriz pelo escalar rho_vi_vj
	matriz_tensor_lighthill = matriz_cubica;
	matriz_tensor_lighthill(:) = 1;
	matriz_tensor_lighthill = matriz_tensor_lighthill*rho_vi_vj;

	% Calculando a distancia |x - y|
	tamanhos = size(matriz_cubica);
	for x = 1:tamanhos(1)
		for y = 1:tamanhos(2)
			for z = 1:tamanhos(3)
				posicao_x = posicao_ouvinte(1) - x*0.003;
				posicao_y = posicao_ouvinte(2) - y*0.003;
				posicao_z = posicao_ouvinte(3) - z*0.003;
				distancia = sqrt(posicao_x^2 + posicao_y^2 + posicao_z^2);
				A = matriz_tensor_lighthill(x, y, z);
				B =  4*pi*distancia;
				B = 1/B;
				matriz_tensor_lighthill(x, y, z) = A*B;
			end
		end
	end

	% Calculando o laplaciano para depois integrar
	%size(matriz_tensor_lighthill)

	diferenciado_x_tensor_lighthill = diff(matriz_tensor_lighthill, 2, 1);
	diferenciado_x_tensor_lighthill = diferenciado_x_tensor_lighthill;
	diferenciado_xy_tensor_lighthill = diff(diferenciado_x_tensor_lighthill, 2, 2);
	diferenciado_xy_tensor_lighthill = diferenciado_xy_tensor_lighthill;
	diferenciado_xyz_tensor_lighthill = diff(diferenciado_xy_tensor_lighthill, 2, 3);
	laplaciano_tensor_lighthill = diferenciado_xyz_tensor_lighthill;
								
	%size(laplaciano_tensor_lighthill)
	%laplaciano_tensor_lighthill(1,1,:)

	% Calculando a pressao final
	pressao_acustica_x = trapz(laplaciano_tensor_lighthill,1);
	pressao_acustica_xy = trapz(pressao_acustica_x,2);
	pressao_acustica = trapz(pressao_acustica_xy,3);