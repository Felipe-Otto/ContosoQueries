-- CREATE VIEW
CREATE VIEW vwProdutos AS
SELECT
	A.BrandName AS 'Marca',
	A.ColorName AS 'Cor',
	COUNT(*) AS 'Quantidade Vendida',
	ROUND(SUM(B.SalesAmount), 2) AS 'Receita Total '
FROM
	DimProduct A
INNER JOIN FactSales B
	ON A.ProductKey =  B.ProductKey
GROUP BY 
	A.BrandName, A.ColorName
GO

-- 1. 
SELECT
	*,
	SUM([Quantidade Vendida]) OVER() AS 'Totald e Produtos Vendidos'
FROM
	vwProdutos

-- 2.
SELECT
	*,
	SUM([Quantidade Vendida]) OVER(PARTITION BY Marca) AS 'Total de Produtos Vendidos/Marca'
FROM
	vwProdutos

-- 3.
SELECT
	*,
	FORMAT(CAST(SUM([Quantidade Vendida]) OVER(PARTITION BY Marca) AS FLOAT)/SUM([Quantidade Vendida]) OVER(), '0.00%') AS 'Porcentagem'
FROM
	vwProdutos

-- 4.
SELECT
	Marca,
	Cor,
	[Quantidade Vendida],
	RANK() OVER(ORDER BY [Quantidade Vendida] DESC) AS 'Rank'
FROM
	vwProdutos

-- Desafio --
CREATE VIEW vwHistoricoLojas AS
SELECT
	ROW_NUMBER() OVER(ORDER BY A.CalendarMonth) AS 'ID',
	A.CalendarYear AS 'Ano', 
	A.CalendarMonthLabel AS 'Mês', 
	COUNT(B.OpenDate) AS 'Qtd_Lojas'
FROM
	DimDate A
LEFT JOIN DimStore B
	ON A.Datekey = B.OpenDate
GROUP BY
	CalendarYear, CalendarMonthLabel, CalendarMonth
GO

-- 5.
SELECT
	*,
	SUM(Qtd_Lojas) OVER (ORDER BY Qtd_Lojas ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel'
FROM
	vwHistoricoLojas

-- 6.
SELECT
	*,
	SUM(Qtd_Lojas) OVER(ORDER BY Qtd_Lojas ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)
FROM
	vwHistoricoLojas

-- Desafio --
CREATE DATABASE Desafio
USE Desafio

CREATE TABLE Calendario(
	Data DATE
)

DECLARE @varAnoInicial INT = YEAR((SELECT MIN(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))

DECLARE @varAnoFinal INT = YEAR((SELECT MAX(DateFirstPurchase) FROM ContosoRetailDW.dbo.DimCustomer))

DECLARE @varDataInicial DATE = DATEFROMPARTS(@varAnoInicial, 1, 1)
DECLARE @varDataFinal DATE = DATEFROMPARTS(@varAnoFinal, 12, 31)

WHILE @varDataInicial < @varDataFinal
BEGIN
	INSERT INTO 
		Calendario(Data) 
	VALUES 
		(@varDataInicial)
	SET @varDataInicial = DATEADD(DAY, 1, @varDataInicial)
END


ALTER TABLE Calendario
ADD Ano INT,
	Mes INT,
	Dia INT,
	AnoMes INT,
	NomeMes VARCHAR(50)

UPDATE 
	Calendario 
SET 
	Ano = YEAR(Data),
	Mes = MONTH(Data),
	Dia = DAY(Data),
	AnoMes = CONCAT(YEAR(Data), FORMAT(MONTH(Data), '00')),
	NomeMes = CASE
				WHEN MONTH(Data) = 1 THEN 'Janeiro'	
				WHEN MONTH(Data) = 2 THEN 'Fevereiro'	
				WHEN MONTH(Data) = 3 THEN 'Março'	
				WHEN MONTH(Data) = 4 THEN 'Abril'	
				WHEN MONTH(Data) = 5 THEN 'Maio'	
				WHEN MONTH(Data) = 6 THEN 'Junho'	
				WHEN MONTH(Data) = 7 THEN 'Julho'	
				WHEN MONTH(Data) = 8 THEN 'Agosto'	
				WHEN MONTH(Data) = 9 THEN 'Setembro'	
				WHEN MONTH(Data) = 10 THEN 'Outubro'	
				WHEN MONTH(Data) = 11 THEN 'Novembro'	
				WHEN MONTH(Data) = 12 THEN 'Dezembro'	
			  END

CREATE VIEW vwNovosClientes AS
SELECT
	ROW_NUMBER() OVER(ORDER BY AnoMes) AS 'ID',
	Ano,
	NomeMes,
	COUNT(B.DateFirstPurchase) AS 'Novos Clientes'
FROM Calendario A
LEFT JOIN ContosoRetailDW.dbo.DimCustomer B
	ON A.Data = B.DateFirstPurchase
GROUP BY
	Ano, NomeMes, AnoMes
GO

-- 7. a)
SELECT
	*,
	SUM([Novos Clientes]) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Soma Móvel'
FROM
	vwNovosClientes

-- 7. b)
SELECT
	*,
	AVG([Novos Clientes]) OVER(ORDER BY ID ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS 'Média Móvel'
FROM	
	vwNovosClientes

-- 7. c)
SELECT
	*,
	SUM([Novos Clientes]) OVER(ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma Acumulada'
FROM
	vwNovosClientes

-- 7. d)
SELECT 
	*,
	AVG([Novos Clientes]) OVER(PARTITION BY Ano ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Soma Acumulada Infra Ano'
FROM
	vwNovosClientes

-- 8.
SELECT
	*,
	LAG([Novos Clientes], 1) OVER(ORDER BY ID),
	FORMAT(CAST([Novos Clientes] AS FLOAT)/NULLIF(LAG([Novos Clientes], 1) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% MoM',
	FORMAT(CAST([Novos Clientes] AS FLOAT)/NULLIF(LAG([Novos Clientes], 12) OVER(ORDER BY ID), 0) - 1, '0.00%') AS '% YoY'
FROM
	vwNovosClientes