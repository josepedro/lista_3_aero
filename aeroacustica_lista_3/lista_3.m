clear('all');
close all;

% Lista de Exercícios 3

disp('Questão 1.1 ----------------------');
velocidades = open('velocidades.mat');
velocidades_x = velocidades.vel_x(:,:,1);
velocidades_y = velocidades.vel_y(:,:,1);
rho = 1.2; % kg/m^3
delta_x = 0.003; % m
posicao_ouvinte = [15 15 15]; % m

pressao_acustica = calcular_pressao(rho, delta_x, velocidades.vel_x, velocidades.vel_y, ...
posicao_ouvinte);

valor_referencia = 2*10^-5;
nivel_pressao_sonora_dB = 20*log10((pressao_acustica+valor_referencia)/valor_referencia);

resposta_1 = ['Valor de Pressão Acústica: ', num2str(pressao_acustica, '%10.5e'), ...
' N/m^2'];
disp(resposta_1);

resposta_2 = ['Valor de Nível de Pressao Sonora: ', num2str(nivel_pressao_sonora_dB), ...
' dB'];
disp(resposta_2);

disp('Questão 1.2 ----------------------');
% Plotando mapa de superfície de velocidade absoluta
velocidades_absolutas = sqrt(velocidades_x.^2 + velocidades_y.^2);
[x,y] = meshgrid([0:99]*0.003);
x = x(:, 1:95);
y = y(:, 1:95);
figure;
surf(velocidades_absolutas);
title('Grafico de Velocidades Absolutas');
xlabel('x');
ylabel('y');
zlabel('velocidade absoluta [m/s]');
vorticidade = curl(velocidades_x, velocidades_y);
figure;
surf(x, y, vorticidade);
title('Grafico de Velocidades Vorticiais');
ylabel('y');
xlabel('x');
zlabel('velocidade vorticial [rad/s]');
resposta = ['O valor da dimensao característica é 0.0630 metros ou 63 mm', ...
' pois a turbulencia possui um centro definido com esse diâmetro característico.'];
disp(resposta);	

disp('Questão 1.3 ----------------------');
dimensao_caracteristica_l = 0.063; % m
distancia = sqrt(sum(posicao_ouvinte.^2)); % m 
c0 = 340; % m/s 
velocidade_inicial = ((pressao_acustica*(distancia)*c0^2)/(dimensao_caracteristica_l*rho))^(1/4);
% Plotando grafico de pressao por velocidades atraves da equacao 1
pressao_velocidades_1(1:10) = 0;
pressao_velocidades_2(1:10) = 0;
velocidades_media_x = velocidades.vel_x;
tamanhos = size(velocidades.vel_x);
velocidade_media_x = (sum(sum(sum(velocidades_x))))/tamanhos(1)*tamanhos(2)*tamanhos(3);
velocidades_media_x(:) = 1;
velocidades_media_x = velocidades_media_x*velocidade_media_x;
velocidades_media_y = velocidades.vel_y;
tamanhos = size(velocidades.vel_y);
velocidade_media_y = (sum(sum(sum(velocidades_y))))/tamanhos(1)*tamanhos(2)*tamanhos(3);
velocidades_media_y(:) = 1;
velocidades_media_y = velocidades_media_y*velocidade_media_y;
for divisao = 1:10
	velocidade_divisao = 10^divisao;
	pressao_velocidades_1(divisao) = calcular_pressao(rho, delta_x, velocidades_media_x/velocidade_divisao ...
	, velocidades_media_y/velocidade_divisao, posicao_ouvinte);
	velocidade = velocidade_inicial/velocidade_divisao;
	pressao_velocidades_2(divisao) = (dimensao_caracteristica_l/distancia)*(rho*velocidade^4)/c0^2;
end
figure;
loglog(pressao_velocidades_1);
hold on;
loglog(pressao_velocidades_2, 'r');
title('Grafico Pressao Sonora em Relacao a Velocidade Absoluta');
ylabel('pressao acustica');
xlabel('velocidade');
legend('Equacao de Lighthill', 'Aproximacao da Oitava Potencia');
% Pergunta: os resultados coincidem? Justifique a sua resposta de maneira crítica.
% Os dois gráficos possuem comportamentos similares visto que a pressão sonora decai exponencialmente ao longo
% da variação de velocidades. Esse fato ocorre pois nas duas equações se considera que o som é gerado a partir 
% de somas compactas oriundas de fontes sonoras, independentes,
% que possuem o volume definido por V0/l^3, dado que l é a dimensão característica de cada vórtice.
% Dado esse contexto, na expansão em campo distante o termo de retardamento se aproxima de 0 pois é considerado
% que a análise dos vórtices é feita na origem do sistema, desconsiderando assim o efeito do retardamento. Nesse caso
% a integral da solução de Green em campo distante se delimita em pho0*v^2*l^3.

disp('Questão 2.1 ----------------------');

%size(vorticidade)
%size(velocidades_absolutas)
% Calculando a potencia pegando a posicao (10, 10, 10) do vortice
v_linha = [0 0 35];
vorticidade = curl(velocidades.vel_x(:,:,1), velocidades.vel_y(:,:,1));
vorticidade_media = mean(mean(mean(vorticidade)));
matriz_vorticidade = velocidades.vel_x;
matriz_vorticidade(:) = 1;
vorticidade = matriz_vorticidade*vorticidade_media;
tamanhos = size(vorticidade);
matriz_produto_vetorial_x = vorticidade;
matriz_produto_vetorial_y = vorticidade;
matriz_produto_vetorial_z = vorticidade;
matriz_produto_vetorial_x(:) = 0;
matriz_produto_vetorial_y(:) = 0;
matriz_produto_vetorial_z(:) = 0;
matriz_w_v_vlinha = velocidades.vel_x(:,:,1);
for x = 1:tamanhos(1)
	for y = 1:tamanhos(2)
		for z = 1:tamanhos(3)
			termo_1 = [vorticidade(x,y,z) vorticidade(x,y,z) vorticidade(x,y,z)];
			termo_2 = [velocidades.vel_x(x,y,z) velocidades.vel_y(x,y,z) velocidades.vel_z(x,y,z)];
			produto_vetorial = cross(termo_1, termo_2);
			matriz_produto_vetorial_x(x,y,z) = produto_vetorial(1);
			matriz_produto_vetorial_y(x,y,z) = produto_vetorial(2);
			matriz_produto_vetorial_z(x,y,z) = produto_vetorial(3);
			matriz_w_v_vlinha(x,y,z) = sum(produto_vetorial.*v_linha);
		end
	end
end

% Integrando a matriz oriunda de w, v e v'
integracao_x_matriz_w_v_vlinha = trapz(matriz_w_v_vlinha,1);
integracao_xy_matriz_w_v_vlinha = trapz(integracao_x_matriz_w_v_vlinha,2);
integral_matriz_w_v_vlinha = trapz(integracao_xy_matriz_w_v_vlinha,3);

% Multiplicando por -rho
potencia_instantanea = -rho*integral_matriz_w_v_vlinha



%w = vorticidade()
%cross()	
