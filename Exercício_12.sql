-- 1. 
SELECT
	*
FROM
	FactSales 
WHERE StoreKey = (
			SELECT StoreKey FROM DimStore 
			WHERE StoreName = 'Contoso Orlando Store'
			)

-- 2. a)
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Preço'
FROM
	DimProduct
WHERE UnitPrice > (
		SELECT 
			UnitPrice 
		FROM 
			DimProduct
		WHERE 
			ProductKey = 1893
		)

-- 2. b)
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Preço',
	(SELECT 
		UnitPrice 
	 FROM 
		DimProduct
	 WHERE ProductKey = 1893
	 ) AS 'Preço Base'
FROM
	DimProduct
WHERE 
	UnitPrice > (
		SELECT 
			UnitPrice 
		FROM 
			DimProduct
		WHERE 
			ProductKey = 1893
		)

-- 3.
SELECT
	*
FROM
	DimEmployee
WHERE
	DepartmentName = (
		SELECT 
			DepartmentName 
		FROM 
			DimEmployee
		WHERE 
			FirstName = 'Miguel'
		AND 
			LastName = 'Severino')

-- 4.
SELECT
	CustomerKey AS 'ID do Cliente',
	FirstName AS 'Nome',
	LastName AS 'Sobrenome',
	EmailAddress AS 'E-mail',
	FORMAT(YearlyIncome, 'C') AS 'Salário Anual'
FROM
	DimCustomer
WHERE 
	YearlyIncome > (
		SELECT 
			AVG(YearlyIncome) 
		FROM 
			DimCustomer
		WHERE 
			CustomerType = 'Person')

-- 5.		
SELECT 
	*
FROM
	DimCustomer
WHERE 
	CustomerKey IN (
		SELECT 
			CustomerKey 
		FROM 
			FactOnlineSales
		WHERE 
			PromotionKey IN (
				SELECT 
					PromotionKey 
				FROM 
					DimPromotion
				WHERE 
					PromotionName = 'Asian Holiday Promotion'))

-- 6. 
SELECT
	CustomerKey,
	FirstName
FROM
	DimCustomer
WHERE CustomerKey IN (
		SELECT 
			CustomerKey 
		FROM 
			FactOnlineSales
		GROUP BY 
			CustomerKey, ProductKey
		HAVING 
			COUNT(*) >= 3000)


-- 7.
SELECT
	ProductKey AS 'ID do Produto',
	ProductName AS 'Produto',
	BrandName AS 'Marca',
	UnitPrice AS 'Preço Unico',
	ROUND((SELECT AVG(UnitPrice) FROM DimProduct), 2) AS 'Preço Médio'
FROM
	DimProduct 

-- 8. 
SELECT
	MAX(Quantidade) AS 'Máximo',
	MIN(Quantidade) AS 'Mínimo',
	AVG(Quantidade) AS 'Média'
FROM
	(
	SELECT
		BrandName, 
		COUNT(*) AS 'Quantidade'
	FROM
		DimProduct
	GROUP BY
		BrandName
	) AS T

-- 9. 
WITH CTE_QtdProdutosPorMarca AS(
	SELECT
		BrandName, 
		COUNT(*) AS 'Quantidade'
	FROM
		DimProduct
	GROUP BY 
		BrandName
)

SELECT 
	MAX(Quantidade) AS 'Quantidade'
FROM
	CTE_QtdProdutosPorMarca;

-- 10.
WITH CTE_ProdutosAdventureWorks AS(
	SELECT
		ProductKey,
		ProductName,
		ProductSubcategoryKey,
		BrandName,
		UnitPrice
	FROM
		DimProduct
	WHERE
		BrandName = 'Adventure Works'
), 
CTE_CategoriaTelevisonsEMonitors AS (
	SELECT
		ProductSubcategoryKey,
		ProductSubcategoryName
	FROM
		DimProductSubcategory
	WHERE
		ProductSubcategoryName IN ('Televisions', 'Monitors')
)

SELECT 
	A.*,
	B.ProductSubcategoryName
FROM
	CTE_ProdutosAdventureWorks A
LEFT JOIN CTE_CategoriaTelevisonsEMonitors B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey