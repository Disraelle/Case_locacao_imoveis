CREATE DATABASE locacao;

SELECT * FROM dw.fato_locacao
SELECT * FROM dw.dim_cliente
SELECT * FROM dw.dim_carro
SELECT * FROM dw.dim_combustivel
SELECT * FROM dw.dim_data
SELECT * FROM dw.dim_vendedor


--Quantidade de diarias por tipo de combustivel (Ordenação decrescente)
SELECT tipocombustivel   AS tipo_combustivel
     , count (qtddiaria) AS qtd_diaria
  FROM  dw.fato_locacao f
 INNER JOIN dw.dim_combustivel c ON c.idcombustivel = f.idcombustivel
 WHERE 1=1
 GROUP BY tipocombustivel
 ORDER BY qtd_diaria DESC
 
 -- Valor de locaçao por estado (Ordenação decrescente)
SELECT DISTINCT c.estadocliente               AS estado_cliente
      , sum (f.vlrdiaria) * sum (f.qtddiaria) AS valor_total_diarias
  FROM  dw.fato_locacao f
 INNER JOIN dw.dim_cliente c ON c.idcliente = f.idcliente
 WHERE 1=1
 GROUP BY c.estadocliente
 ORDER BY valor_total_diarias DESC
 
-- Valor de locaçao por data (Ordenação decrescente)
SELECT cast (f.datalocacao as date) AS estado_cliente
     , sum (f.vlrdiaria) * sum (f.qtddiaria) AS valor_total_diarias
  FROM  dw.fato_locacao f
 WHERE 1=1
 GROUP BY f.datalocacao
 ORDER BY valor_total_diarias DESC
 
 -- Valor total de locações
SELECT sum (f.vlrdiaria) * sum (f.qtddiaria) AS valor_total_diarias
   FROM dw.fato_locacao f
 
 -- Valor total de locações por vendedor (Ordenação decrescente)
SELECT DISTINCT v.nomevendedor AS nome_vendedor
      , sum (f.vlrdiaria) * sum (f.qtddiaria) AS valor_total_diarias
  FROM  dw.fato_locacao f
 INNER JOIN dw.dim_vendedor v ON v.idvendedor = f.idvendedor
 WHERE 1=1
 GROUP BY v.nomevendedor
 ORDER BY valor_total_diarias DESC
 
-- Total de locações por cliente (Ordenação decrescente)
SELECT DISTINCT c.nomecliente AS nome_cliente
      , sum (f.vlrdiaria) * sum (f.qtddiaria) AS valor_total_diarias
  FROM  dw.fato_locacao f
 INNER JOIN dw.dim_cliente c ON c.idcliente = f.idcliente
 WHERE 1=1
 GROUP BY c.nomecliente
 ORDER BY  valor_total_diarias DESC  
 
 -- Modelo de carro mais locado - Quantidade de diarias (Ordenação decrescente)
SELECT DISTINCT c.modelocarro AS modelo_carro
     , sum (qtddiaria)      AS quantidade_diarias
  FROM  dw.fato_locacao f
 INNER JOIN dw.dim_carro c ON c.classicarro = f.classicarro
 WHERE 1=1
 GROUP BY c.modelocarro
 ORDER BY quantidade_diarias DESC  
 
-- Quantidade de diarias e valor total por carros locados (Ordenação decrescente)
SELECT DISTINCT c.modelocarro AS modelo_carro
     , sum (qtddiaria)      AS quantidade_diarias
	 , sum (f.vlrdiaria) * sum (f.qtddiaria) AS valor_total_diarias
  FROM  dw.fato_locacao f
 INNER JOIN dw.dim_carro c ON c.classicarro = f.classicarro
 WHERE 1=1
 GROUP BY c.modelocarro
 ORDER BY valor_total_diarias DESC  
 

 
  