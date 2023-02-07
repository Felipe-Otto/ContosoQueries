-- 1.
SELECT 
	SUM(SalesQuantity) AS 'Quantidade Vendidas',
	SUM(ReturnQuantity) AS 'Quantidade Devolvida'
FROM 
	FactSales

-- 2.
SELECT 
	AVG(YearlyIncome) AS 'M�dia Salarial'
FROM 
	DimCustomer
WHERE
	Occupation = 'Professional'

-- 3. a)
SELECT 
	MAX(EmployeeCount) AS 'Quantidade M�xima de Funcion�rios'
FROM
	DimStore

-- 3. b)
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Total de Funcion�rios'
FROM
	DimStore
ORDER BY
	EmployeeCount DESC

-- 3. c)
SELECT 
	MIN(EmployeeCount) AS 'Quantidade M�nima de Funcion�rios'
FROM 
	DimStore

-- 3. d)
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Total de Funcion�rio'
FROM
	DimStore
WHERE 
	EmployeeCount IS NOT NULL
ORDER BY 
	EmployeeCount ASC

-- 4. a)
SELECT 
	COUNT(Gender)
FROM
	DimEmployee
WHERE
--	Gender = 'F'
	Gender = 'M'

-- 4. b)
SELECT 
	TOP(1) FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	HireDate AS 'Data de Contrata��o'
FROM 
	DimEmployee
WHERE 
--  Gender = 'F'
	Gender = 'M'
ORDER BY
	HireDate

-- 5. a)
SELECT
	COUNT(DISTINCT(ColorName)) AS 'Quantidade Distinta de Cores'
FROM
	DimProduct

-- 5. b)
SELECT
	COUNT(DISTINCT(BrandName))  AS 'Quantidade Distinta de Marcas'
FROM
	DimProduct

-- 5. c)
SELECT 
	COUNT(DISTINCT(ClassName)) AS 'Quantidade Distinta de Produtos'
FROM DimProduct