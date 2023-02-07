-- 1. a)
SELECT
	ProductName AS 'Nome do Produto',
	LEN(ProductName) AS 'Caracteres'
FROM
	DimProduct
ORDER BY 
	LEN(ProductName) DESC

-- 1. b)
SELECT
	AVG(LEN(ProductName)) AS 'Média de Caracteres'
FROM
	DimProduct

-- 1. c) 
SELECT
	REPLACE(REPLACE(REPLACE(REPLACE(ProductName, BrandName, ''), ColorName, ''), 'WWI', ''), 'NT', '')
FROM
	DimProduct

-- 1. d) 
SELECT
	AVG(LEN(REPLACE(REPLACE(REPLACE(REPLACE(ProductName, BrandName, ''), ColorName, ''), 'WWI', ''), 'NT', ''))) AS 'Média de Caracteres'
FROM
	DimProduct

-- 2.
SELECT
	ProductName AS 'Nome do Produto',
	StyleName AS 'Código do Produto',
	TRANSLATE(StyleName, '0123456789', 'ABCDEFGHIJ') AS 'Código Novo'
FROM
	DimProduct

-- 3.
SELECT
	CONCAT(FirstName, ' ', LastName) AS 'Nome Completo',
	EmailAddress AS 'E-mail',
	LEFT(EmailAddress, CHARINDEX('@', EmailAddress)) AS 'ID E-mail',
	CONCAT(UPPER(FirstName), DAY(BirthDate)) AS 'Senha'
FROM
	DimEmployee

-- 4.
SELECT
	FirstName AS 'Nome',
	EmailAddress AS 'E-mail',
	AddressLine1 AS 'Endereço',
	DateFirstPurchase AS 'Primeira Compra'
FROM
	DimCustomer
WHERE
	YEAR(DateFirstPurchase) = 2001

-- 5.
SELECT
	FirstName AS 'Nome', 
	EmailAddress AS 'E-mail',
	HireDate AS 'Data Contratação',
	FORMAT(HireDate, 'dd') AS 'Dia',
	FORMAT(HireDate, 'MMMM') AS 'Mês',
	FORMAT(HireDate, 'yyyy') AS 'Ano'
FROM
	DimEmployee

-- 6.
SELECT
	TOP(1) StoreName AS 'Nome da Loja',
	DATEDIFF(DAY, OpenDate, GETDATE()) AS 'Dias Abertos'
FROM
	DimStore
ORDER BY
	DATEDIFF(DAY, OpenDate, GETDATE()) DESC

