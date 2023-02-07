-- 1. a)CREATE VIEW vwProducts ASSELECT	ProductName AS 'Nome do Produto', 	ColorName AS 'Cor', 	UnitPrice AS 'Preço', 	UnitCost AS 'Custo Unitário'FROM 	DimProductGO-- 1. b)CREATE VIEW vwFuncionarios ASSELECT	FirstName AS 'Nome', 
	BirthDate AS 'Data de Nascimento',
	DepartmentName AS 'Departamento'FROM	DimEmployeeGO-- 1. c)CREATE VIEW vwLojas ASSELECT	StoreKey AS 'ID da Loja', 
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura'FROM	DimStoreGO-- 2.CREATE VIEW vwClientes AS
SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	REPLACE(REPLACE(Gender, 'M', 'Masculino'), 'F', 'Feminino') As 'Gênero',
	EmailAddress AS 'E-mail',
	FORMAT(YearlyIncome, 'C') AS 'Renda Anual'
FROM
	DimCustomer
GO

-- 3. a)
CREATE VIEW vwLojasAtivas AS
SELECT
	*
FROM
	DimStore
WHERE
	Status = 'On'
GO

-- 3. b)
CREATE VIEW vwFuncionariosMkt AS
SELECT
	FirstName AS 'Nome', 
	EmailAddress AS 'E-mail',
	DepartmentName AS 'Departamento'
FROM
	DimEmployee
WHERE DepartmentName = 'Marketing'
GO

-- 3. c)
CREATE VIEW vwContosoLitwareSilver AS 
SELECT
	*
FROM
	DimProduct
WHERE
	BrandName IN('Contoso', 'Litware')
AND
	ColorName = 'Silver'
GO
-- 4.CREATE VIEW vwTotalVendidoProdutos ASSELECT	B.ProductName AS 'Nome do Produto',	SUM(A.SalesQuantity) AS 'Quantidade Total Vendida'FROM	FactSales AINNER JOIN DimProduct B	ON A.ProductKey = B.ProductKeyGROUP BY	B.ProductNameGO-- 5. a)ALTER VIEW vwProducts ASSELECT	ProductName AS 'Nome do Produto', 	ColorName AS 'Cor', 	UnitPrice AS 'Preço', 	UnitCost AS 'Custo Unitário', 	BrandName AS 'Nome da Marca'FROM	DimProductGO-- 5. b)ALTER VIEW vwFuncionarios ASSELECT	FirstName AS 'Nome', 
	BirthDate AS 'Data de Nascimento',
	DepartmentName AS 'Departamento'FROM	DimEmployeeWHERE	Gender = 'F'GO-- 5. c)ALTER VIEW vwLojas ASSELECT	StoreKey AS 'ID da Loja', 
	StoreName AS 'Nome da Loja',
	OpenDate AS 'Data de Abertura'FROM	DimStoreWHERE 	Status = 'On'GO

-- 6. a)
CREATE VIEW vw_6a AS
SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'Total de Produtos'
FROM
	DimProduct
GROUP BY
	BrandName
GO

-- 6. b)
ALTER VIEW vw_6a AS
SELECT
	BrandName AS 'Nome da Marca',
	COUNT(*) AS 'Total de Produtos',
	SUM(Weight) AS 'Peso Total'
FROM
	DimProduct
GROUP BY
	BrandName
GO

-- 6. c)
DROP VIEW vw_6a
