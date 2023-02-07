-- 1. a)
SELECT
	B.ChannelName AS 'Canal de Vendas',
	SUM(A.SalesQuantity) AS 'Total Vendido'
FROM
	FactSales A
INNER JOIN DimChannel B
	ON A.ChannelKey = B.ChannelKey
GROUP BY 
	B.ChannelName
ORDER BY
	SUM(A.SalesQuantity) DESC

-- 1. b)
SELECT
	A.StoreName AS 'Loja',
	SUM(B.SalesQuantity) AS 'Total Vendido',
	SUM(B.ReturnQuantity) AS 'Total Devolvido'
FROM
	DimStore A
INNER JOIN FactSales B
	ON A.StoreKey = B.StoreKey
GROUP BY
	A.StoreName
ORDER BY
	A.StoreName

-- 1. c)
SELECT
	A.CalendarYear AS 'Ano',
	A.CalendarMonthLabel AS 'Mês',
	SUM(B.SalesAmount) AS 'Faturamento'
FROM
	DimDate A
INNER JOIN FactSales B
	ON A.Datekey = B.DateKey
GROUP BY
	A.CalendarYear, A.CalendarMonthLabel, A.CalendarMonth
ORDER BY
	A.CalendarMonth

-- 2. a)
SELECT 
	TOP(1) A.ColorName AS 'Cor',
	SUM(B.SalesQuantity) AS 'Quantidade Vendida'
FROM
	DimProduct A
INNER JOIN FactSales B
	ON A.ProductKey = B.ProductKey
GROUP BY
	A.ColorName
ORDER BY 
	SUM(B.SalesQuantity) DESC

-- 2. b)
SELECT
	A.ColorName AS 'Cor',
	SUM(B.SalesQuantity) AS 'Quantidade Vendidas'
FROM
	DimProduct A
INNER JOIN FactSales B
	ON A.ProductKey = B.ProductKey
GROUP BY
	A.ColorName
HAVING
	SUM(B.SalesQuantity) >= 3000000

-- 3.
SELECT
	D.ProductCategoryName AS 'Categoria',
	SUM(A.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactSales A
INNER JOIN DimProduct B
	ON A.ProductKey = B.ProductKey
		INNER JOIN DimProductSubcategory C
			ON B.ProductSubcategoryKey = C.ProductSubcategoryKey
				INNER JOIN DimProductCategory D
					ON C.ProductCategoryKey = D.ProductCategoryKey
GROUP BY
	D.ProductCategoryName

-- 4. a)
SELECT 
	TOP(1) A.CustomerKey,
	B.FirstName AS 'Nome',
	B.LastName AS 'Sobrenome',
	SUM(A.SalesQuantity) AS 'Quantidade Vendida'
FROM
	FactOnlineSales A
INNER JOIN DimCustomer B
	ON A.CustomerKey = B.CustomerKey
WHERE
	B.CustomerType = 'Person'
GROUP BY 
	A.CustomerKey, B.FirstName, B.LastName
ORDER BY 
	SUM(A.SalesQuantity) DESC

-- 4. b)
SELECT 
	TOP(10)	C.ProductName AS 'Produto',
	SUM(B.SalesQuantity) AS 'Quantidade Vendida'
FROM
	DimCustomer A
INNER JOIN FactOnlineSales B
	ON A.CustomerKey = B.CustomerKey
		INNER JOIN DimProduct C
			ON B.ProductKey = C.ProductKey
WHERE
	A.CustomerKey = 7665
GROUP BY
	C.ProductName
ORDER BY
	SUM(B.SalesQuantity) DESC

-- 5.
SELECT
	B.Gender AS 'Sexo',
	SUM(A.SalesQuantity) AS 'Produtos Comprados'
FROM
	FactOnlineSales A
INNER JOIN DimCustomer B
	ON A.CustomerKey = B.CustomerKey
WHERE 
	B.Gender IS NOT NULL
GROUP BY
	B.Gender

-- 6.
SELECT
	B.CurrencyDescription,
	AVG(A.AverageRate) AS 'Taxa Média'
FROM
	FactExchangeRate A
INNER JOIN DimCurrency B
	ON A.CurrencyKey = B.CurrencyKey
GROUP BY
	B.CurrencyDescription
HAVING
	AVG(A.AverageRate) BETWEEN 10 AND 100

-- 7.
SELECT 
	B.ScenarioName AS 'Cenário',
	SUM(A.Amount) AS 'Total'
FROM
	FactStrategyPlan A
INNER JOIN DimScenario B
	ON A.ScenarioKey = B.ScenarioKey
WHERE
	B.ScenarioName IN ('Actual', 'Budget')
GROUP BY
	B.ScenarioName

-- 8.
SELECT
	B.CalendarYear AS 'Ano',
	SUM(A.Amount) AS 'Total'
FROM
	FactStrategyPlan A
INNER JOIN DimDate B
	ON A.Datekey = B.Datekey
GROUP BY
	B.CalendarYear

-- 9.
SELECT 
	B.ProductSubcategoryName AS 'Sub-categoria',
	COUNT(*) AS 'Total de Produtos'
FROM
	DimProduct A
INNER JOIN DimProductSubcategory B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
WHERE
	A.BrandName = 'Contoso'
AND
	A.ColorName = 'Silver'
GROUP BY
	B.ProductSubcategoryName

-- 10.
SELECT
	A.BrandName AS 'Marca',
	B.ProductSubcategoryName AS 'Sub-Categoria',
	COUNT(*) AS 'Total de Produtos'
FROM
	DimProduct A
INNER JOIN DimProductSubcategory B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
GROUP BY
	A.BrandName, B.ProductSubcategoryName
ORDER BY
	A.BrandName, B.ProductSubcategoryName, COUNT(A.ProductKey)
