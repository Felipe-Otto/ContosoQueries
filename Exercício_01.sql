-- Conectando à Base de Dados
USE ContosoRetailDW

-- 1. a)
SELECT COUNT(ProductKey) FROM DimProduct

-- 1. b)
SELECT COUNT(CustomerKey) FROM DimCustomer

-- 2. a)
SELECT 
	CustomerKey,
	FirstName,
	EmailAddress,
	BirthDate
FROM
	DimCustomer

-- 2. b)
SELECT 
	CustomerKey AS 'Chave Primária',
	FirstName AS 'Primeiro Nome',
	EmailAddress As 'E-mail',
	BirthDate As 'Data de Nascimento'
FROM
	DimCustomer

-- 3. a)
SELECT 
	TOP(100) *
FROM
	DimCustomer

-- 3. b)
SELECT 
	TOP (20) PERCENT *
FROM
	DimCustomer

-- 3. c)
SELECT
	TOP(100) FirstName,
	EmailAddress, 
	BirthDate
FROM
	DimCustomer

-- 3. d)
SELECT 
	TOP(100) FirstName AS 'Primeiro Nome',
	EmailAddress AS 'E-mail',
	BirthDate AS 'Data Nascimento'
FROM
	DimCustomer

-- 4.
SELECT 
	DISTINCT(Manufacturer) AS 'Fornecedor'
FROM 
	DimProduct

-- 5.
SELECT
	COUNT(DISTINCT(ProductKey)) AS 'Produtos Vendidos'
FROM
	FactSales

