-- 1. a) 
SELECT
	ChannelKey AS 'ID Canal de Vendas',
	SUM(SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales
GROUP BY
	ChannelKey
	
-- 1. b) 
SELECT
	StoreKey AS 'ID Loja', 
	SUM(SalesQuantity) AS 'Quantidade Vendida',
	SUM(ReturnQuantity) AS 'Quantidade Devolvida'
FROM
	FactSales
GROUP BY
	StoreKey
ORDER BY 
	StoreKey

-- 1. c)
SELECT 
	ChannelKey AS 'ID do Canal',
	SUM(SalesAmount) AS 'Total de Vendas'
FROM
	FactSales
WHERE
	YEAR(DateKey) = 2007
GROUP BY
	ChannelKey

-- 2. a)
SELECT
	ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'	
FROM
	FactSales
GROUP BY
	ProductKey
HAVING
	SUM(SalesAmount) > 5000000
ORDER BY 
	SUM(SalesAmount) DESC

-- 2. b)
SELECT
	TOP(10) ProductKey AS 'ID do Produto',
	SUM(SalesAmount) AS 'Faturamento Total'		
FROM
	FactSales
GROUP BY
	ProductKey
ORDER BY 
	SUM(SalesAmount) DESC

-- 3. a)
SELECT
	TOP (1) CustomerKey AS 'ID Cliente',
	SUM(SalesQuantity) AS 'Total de Compras'
FROM
	FactOnlineSales
GROUP BY
	CustomerKey
ORDER BY 
	SUM(SalesQuantity) DESC

-- 3. b)
SELECT 
	TOP(3) ProductKey 'ID Produto',
	SUM(SalesQuantity) AS 'Total Vendido'
FROM
	FactOnlineSales
WHERE CustomerKey = 19037
GROUP BY
	ProductKey
ORDER BY
	SUM(SalesQuantity) DESC

-- 4. a)
SELECT
	BrandName AS 'Marca',
	COUNT(ProductKey) AS 'Quantidade de Produtos'
FROM	
	DimProduct
GROUP BY
	BrandName

-- 4. b)
SELECT
	ClassName AS 'Classe',
	AVG(UnitPrice) AS 'Média Preços'
FROM
	DimProduct
GROUP BY
	ClassName

-- 4. c)
SELECT
	ColorName AS 'Cor',
	SUM(Weight) AS 'Peso Total'
FROM
	DimProduct
GROUP BY
	ColorName

-- 5.
SELECT
	StockTypeName AS 'Tipo de Estoque',
	SUM(Weight) AS 'Peso'
FROM
	DimProduct
WHERE 
	BrandName = 'Contoso'
GROUP BY
	StockTypeName
ORDER BY
	SUM(Weight) DESC

-- 6.
SELECT
	BrandName,
	COUNT(DISTINCT(ColorName)) AS 'Total de Cores'
FROM
	DimProduct
GROUP BY
	BrandName
ORDER BY
	COUNT(DISTINCT(ColorName)) DESC

-- 7. 
SELECT
	Gender AS 'Gênero',
	COUNT(Gender) AS 'Total',
	AVG(YearlyIncome) As 'Média Salarial'
FROM
	DimCustomer
WHERE Gender IS NOT NULL
GROUP BY
	Gender

-- 8.
SELECT
	Education AS 'Nível Escolar',
	COUNT(Education) AS 'Total',
	AVG(YearlyIncome) AS 'Média Salárial'
FROM
	DimCustomer
WHERE 
	Education IS NOT NULL
GROUP BY
	Education

-- 9.
SELECT
	DepartmentName AS 'Departamento',
	COUNT(EmployeeKey) AS 'Total de Funcionários'
FROM
	DimEmployee
WHERE
	EndDate IS NULL
GROUP BY
	DepartmentName

-- 10.
SELECT 
	Title AS 'Cargo', 
	SUM(VacationHours) AS 'Horas de Férias'
FROM
	DimEmployee
WHERE 
	Gender = 'F'
AND
	DepartmentName IN ('Production', 'Marketing', 'Engineering', 'Finance')
AND
	YEAR(StartDate) BETWEEN 1999 AND 2000
GROUP BY
	Title

