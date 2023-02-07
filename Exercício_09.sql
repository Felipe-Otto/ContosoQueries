-- 1. a)
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Nome do Produto',
	ClassName AS 'Nome da Classe',
	UnitPrice AS 'Preço',
	CASE	
		WHEN ClassName = 'Economy' THEN 0.05
		WHEN ClassName = 'Regular' THEN 0.07
		ELSE 0.09
	END AS 'Desconto',
	CASE
		WHEN ClassName = 'Economy' THEN ROUND(UnitPrice * (1 - 0.05), 2)
		WHEN ClassName = 'Regular' THEN ROUND(UnitPrice * (1 - 0.07), 2)
		ELSE ROUND(UnitPrice * (1 - 0.09), 2)
	END AS 'Preço Final'
FROM
	DimProduct 

-- 1. b)
DECLARE @Economy FLOAT = 0.05,
		@Regular FLOAT = 0.07,
		@Deluxe FLOAT = 0.09
SELECT
	ProductKey AS 'ID do Produto', 
	ProductName AS 'Nome do Produto',
	ClassName AS 'Nome da Classe',
	UnitPrice AS 'Preço',
	CASE	
		WHEN ClassName = 'Economy' THEN ROUND(UnitPrice * (1 - @Economy), 2)
		WHEN ClassName = 'Regular' THEN ROUND(UnitPrice * (1 - @Regular), 2)
		ELSE ROUND(UnitPrice * (1 - @Deluxe), 2)
	END AS 'Preço Final'
FROM
	DimProduct

-- 2.
SELECT
	BrandName AS 'Marca',
	COUNT(*) AS 'Total de Produtos',
	CASE
		WHEN COUNT(*) >= 500 THEN 'A'
		WHEN COUNT(*) BETWEEN 100 AND 500 THEN 'B'
		ELSE 'C'
	END AS 'Categoria'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	Categoria

-- 3.
SELECT
	StoreName AS 'Nome da Loja', 
	EmployeeCount AS 'Total de Funcionários',
	CASE 
		WHEN EmployeeCount >= 50 THEN 'Acima de 50 funcionários'
		WHEN EmployeeCount >= 40 THEN 'Entre 40 e 50 funcionários'
		WHEN EmployeeCount >= 30 THEN 'Entre 30 e 40 funcionários'
		WHEN EmployeeCount >= 20 THEN 'Entre 20 e 30 funcionários'
		ELSE 'Abaixo de 10 funcionários'
	END AS 'Categoria'
FROM
	DimStore

-- 4.
SELECT
	B.ProductSubcategoryName AS 'Nome Sub-Categoria',
	ROUND(AVG(Weight) * 100, 2) AS 'Peso Estimado',
	CASE
		WHEN ROUND(AVG(Weight) * 100, 2) < 1000 THEN 'Rota 1'
		ELSE 'Rota 2'
	END AS 'Rota'
FROM
	DimProduct A
INNER JOIN DimProductSubcategory B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
GROUP BY 
	B.ProductSubcategoryName

-- 5.
SELECT
	FirstName AS 'Nome',
	Gender AS 'Sexo',
	TotalChildren AS 'Qtd. Filhos',
	EmailAddress AS 'E-mail',
	CASE
		WHEN Gender = 'F' AND TotalChildren > 0 THEN 'Sorteio Mãe do Ano'
		WHEN Gender = 'M' AND TotalChildren > 0 THEN 'Sorteio Pai do Ano'
		ELSE 'Caminhão de Prêmios'
	END AS 'Ação de Marketing'
FROM	
	DimCustomer

-- 6.
SELECT 
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura',
	CloseDate AS 'Data de Fechamento',
	CASE
		WHEN CloseDate IS NULL THEN DATEDIFF(DAY, OpenDate, GETDATE()) 
		ELSE DATEDIFF(DAY, OpenDate, CloseDate) 
	END AS 'Total de Dias'
FROM
	DimStore
ORDER BY
	[Total de Dias] DESC