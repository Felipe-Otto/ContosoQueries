-- 1.
DECLARE @valorInicial INT = 1,
		@valorFinal INT = 10
WHILE @valorInicial <= @valorFinal
BEGIN
	PRINT 'O valor do contador é ' + CAST(@valorInicial AS VARCHAR(2))
	SET @valorInicial += 1
END

-- 2.
DECLARE @anoInicial INT = 1996,
		@anoFinal INT = 2003,
		@contratacao INT 
WHILE @anoInicial <= @anoFinal 
BEGIN
	SET @contratacao = (SELECT COUNT(*) FROM DimEmployee 
						WHERE YEAR(HireDate) = @anoInicial)
	PRINT CONCAT(CAST(@contratacao AS VARCHAR(1000)), 
				 ' contratações em ',
				 CAST(@anoInicial AS VARCHAR(4)))	
	SET @anoInicial += 1
END

-- 3.
DECLARE @dataInicial DATE = '01/01/2021',
		@dataFinal DATE = '31/12/2021'
CREATE TABLE Calendario(
	Data DATE
) 
WHILE @dataInicial <= @dataFinal
BEGIN
	INSERT INTO Calendario(Data) VALUES
		(@dataInicial)
	SET @dataInicial = DATEADD(DAY, 1, @dataInicial)
END
