-- 1.
SELECT 
	TOP(100) SalesAmount
FROM 
	FactSales
ORDER BY 
	SalesAmount DESC

-- 2.
SELECT 
	TOP(10) ProductName AS 'Nome do Produto',
	UnitPrice AS 'Preço Unitário',
	Weight AS 'Peso',
	AvailableForSaleDate AS 'Disponibilidade da Venda'
FROM
	DimProduct
ORDER BY
	UnitPrice DESC,
	Weight DESC,
	AvailableForSaleDate

-- 3. a)
SELECT
	TOP(2) ProductName,
	Weight
FROM	
	DimProduct
WHERE
	Weight > 100

-- 3. b)
SELECT
	ProductName AS 'Nome do Produto',
	Weight AS 'Peso'
FROM
	DimProduct
WHERE
	Weight > 100

-- 3. c)
SELECT
	ProductName AS 'Nome do Produto',
	Weight AS 'Peso'
FROM 
	DimProduct 
WHERE 
	Weight > 100 
ORDER BY 
	Weight DESC

-- 4. a)
SELECT 
	StoreName, 
	OpenDate, 
	EmployeeCount 
FROM 
	DimStore

-- 4. b)
SELECT 
	StoreName AS 'Nome da Loja', 
	OpenDate AS 'Data de Abertura', 
	EmployeeCount AS 'Total de Empregados'
FROM 
	DimStore

-- 4. c)
SELECT 
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura'
FROM 
	DimStore
WHERE 
	CloseDate IS NULL

-- 5.
SELECT
	ProductKey
FROM
	DimProduct
WHERE 
	ProductName LIKE '%Home Theater%'
AND
	AvailableForSaleDate = '2009-15-03'

-- 6. a)
SELECT 
	* 
FROM 
	DimStore
WHERE
	Status = 'Off'

-- 6. b)
SELECT 
	* 
FROM
	DimStore
WHERE 
	CloseDate IS NOT NULL

--  7.
SELECT
	StoreName AS 'Nome da Loja',
	EmployeeCount AS 'Total de Funcionários'
FROM 
	DimStore
WHERE 
	EmployeeCount BETWEEN 1 AND 20 -- Categoria 1
--  EmployeeCount BETWEEN 21 AND 50 -- Categoria 2
--  EmployeeCount > 50 -- Categoria 3

-- 8.
SELECT 
	ProductKey AS 'ID',
	ProductName AS 'Nome do Produto',
	UnitPrice AS 'Preço'
FROM 
	DimProduct
WHERE
	ProductName LIKE '%LCD%'

-- 9.
SELECT 
	ProductName AS 'Nome do Produto',
	ColorName AS 'Cor',
	BrandName AS 'Marca'
	
FROM 
	DimProduct 
WHERE 
	ColorName IN ('Green', 'Orange', 'Black', 'Silver', 'Pink')
AND
	BrandName IN ('Contoso', 'Litware', 'Fabrikam')

-- 10. 
SELECT 
	* 
FROM 
	DimProduct
WHERE
	ColorName = 'Silver'
AND
	BrandName = 'Contoso'
AND
	UnitPrice BETWEEN 10 AND 30
ORDER BY
	UnitPrice DESC
