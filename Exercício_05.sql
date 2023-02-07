-- 1.
SELECT
	A.ProductKey AS 'ID Produto',
	A.ProductName AS 'Produto',
	B.ProductSubcategoryName AS 'Subcategoria'
FROM
	DimProduct A
INNER JOIN DimProductSubcategory B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey

-- 2. 
SELECT
	A.ProductCategoryKey AS 'ID Categoria',
	B.ProductCategoryName AS 'Categoria',
	A.ProductSubcategoryName As 'Subcategoria'
FROM
	DimProductSubcategory A
LEFT JOIN DimProductCategory B
	ON A.ProductCategoryKey = B.ProductCategoryKey

-- 3.
SELECT
	A.StoreKey AS 'ID Loja',
	A.StoreName AS 'Nome da Loja',
	A.EmployeeCount AS 'Total de Funcionários',
	B.ContinentName AS 'Continente',
	B.RegionCountryName AS 'País'
FROM
	DimStore A
LEFT JOIN DimGeography B
	ON A.GeographyKey = B.GeographyKey

-- 4. 
SELECT
	A.ProductKey,
	A.ProductName, 
	A.ProductDescription,
	C.ProductCategoryName
FROM
	DimProduct A
LEFT JOIN DimProductSubcategory B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
		LEFT JOIN DimProductCategory C
			ON B.ProductCategoryKey = C.ProductCategoryKey

-- 5. a)
SELECT
	TOP(100) *
FROM
	FactStrategyPlan

-- 5. b)
SELECT
	A.StrategyPlanKey AS 'ID',
	A.Datekey AS 'Data',
	B.AccountName AS 'Tipo de Conta',
	A.Amount AS 'Montante'
FROM
	FactStrategyPlan A
INNER JOIN DimAccount B
	ON A.AccountKey = B.AccountKey

-- 6.
SELECT
	A.StrategyPlanKey AS 'ID',
	A.Datekey AS 'Data',
	B.ScenarioName AS 'Tipo de Cenário',
	A.Amount AS 'Montante'
FROM
	FactStrategyPlan A
INNER JOIN DimScenario B
	ON A.ScenarioKey = B.ScenarioKey

-- 7. 
SELECT
	A.ProductSubcategoryKey AS 'ID Sub-Categoria',
	A.ProductSubcategoryName AS 'Sub-Categoria'
FROM
	DimProductSubcategory A
LEFT JOIN DimProduct B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
WHERE 
	B.ProductName IS NULL

-- 8. 
SELECT
	DISTINCT(A.BrandName),
	B.ChannelName
FROM
	DimProduct A
CROSS JOIN DimChannel B
WHERE
	A.BrandName IN ('Contoso', 'Fabrikam', 'Litware')

-- 9.
SELECT
	A.OnlineSalesKey  AS 'ID da Venda Online',
	A.DateKey AS 'Data',
	B.PromotionName AS 'Promoção',
	A.SalesAmount AS 'Montante'
FROM
	FactOnlineSales A
INNER JOIN DimPromotion B
	ON A.PromotionKey = B.PromotionKey
WHERE
	B.PromotionName <> 'No Discount'
ORDER BY
	DateKey

-- 10.
SELECT 
	A.SalesKey AS 'ID da Venda',
	B.ChannelName AS 'Nome do Canal',
	C.StoreName AS 'Nome da Loja',
	D.ProductName AS 'Nome do Produto',
	A.SalesAmount As 'Montante'
FROM
	FactSales A
INNER JOIN DimChannel B
	ON A.ChannelKey = B.ChannelKey
		INNER JOIN DimStore C
			ON A.StoreKey = C.StoreKey
				INNER JOIN DimProduct D
					ON A.ProductKey = D.ProductKey
ORDER BY
	SalesAmount DESC