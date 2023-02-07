-- 1.
DECLARE @valor1 INT = 10,
		@valor2 INT = 5,
		@valor3 INT = 34,
		@valor4 INT = 7

-- 1. a)
DECLARE @soma INT = (@valor1 + @valor2)
SELECT
	@soma AS 'Soma'

-- 1. b)
DECLARE @subtracao INT = (@valor3 - @valor2)
SELECT
	@subtracao AS 'Subtração'

-- 1. c)
DECLARE @multiplicacao INT = (@valor1 * @valor4)
SELECT 
	@multiplicacao AS 'Multiplicação'

-- 1. d)
DECLARE @divisao FLOAT = (CAST(@valor3 AS FLOAT) / @valor4)
SELECT
	@divisao AS 'Divisão'

-- 1. e)
SELECT ROUND(@divisao, 2, 1)

-- 2. a)
DECLARE @produto VARCHAR(10)= 'Celular'

-- 2. b)
DECLARE @quantidade INT = 12

-- 2. c)
DECLARE @preco FLOAT = 9.99

-- 2. d)
DECLARE @faturamento FLOAT = (@quantidade * @preco)

-- 2. e)
SELECT
	@produto AS 'Produto',
	@quantidade AS 'Quantidade',
	@preco AS 'Preço',
	@faturamento AS 'Faturamento'

-- 3.
DECLARE
	@nome VARCHAR(4) = 'Otto',
	@nascimento DATETIME = '20/09/2000',
	@num_pets INT = 4
SELECT 
	'Meu nome é ' +
	@nome +
	', nasci em ' +
	CAST(FORMAT(@nascimento, 'dd/MM/yyyy') AS VARCHAR(10)) +
	' e tenho ' +
	CAST(@num_pets AS VARCHAR(1)) +
	' pets.' AS Frase

-- 4.
DECLARE @nome_lojas VARCHAR(50) = ''
SELECT 
	@nome_lojas = @nome_lojas + ' e ' + StoreName
FROM
	DimStore
WHERE
	YEAR(CloseDate) = 2008
PRINT 'As lojas fechadas no ano de 2008 foram: ' +
		RIGHT(@nome_lojas, DATALENGTH(@nome_lojas) - 2)

-- 5.
DECLARE @produtos VARCHAR(4000) = ''
SELECT
	@produtos = @produtos + A.ProductName + ', '
FROM
	DimProduct A
INNER JOIN DimProductSubcategory B
	ON A.ProductSubcategoryKey = B.ProductSubcategoryKey
WHERE
	B.ProductSubcategoryName = 'Lamps'
PRINT(LEFT(@produtos, DATALENGTH(@produtos) - 2))
