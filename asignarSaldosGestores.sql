CREATE OR ALTER PROCEDURE AsignarSaldosGestores
AS
BEGIN
    DECLARE @TotalGestores INT;
    DECLARE @TotalSaldos INT;
    DECLARE @SaldoIndex INT = 1;
    DECLARE @GestorIndex INT =1;
    DECLARE @GestorId INT;
    DECLARE @GestorNombre VARCHAR(50);
    DECLARE @SaldoId INT;
    DECLARE @Saldo DECIMAL(18,2);
    DECLARE @Iteraciones INT;
    DECLARE @IteracionActual INT = 1;

    -- Crear tabla temporal con saldos ordenados
    CREATE TABLE #TempAsignaciones (
                                       Gestores VARCHAR(50),
                                       Saldos DECIMAL(10,2)
    );

    CREATE TABLE #TempSaldos (
                                 ID INT IDENTITY(1,1) PRIMARY KEY,
                                 Saldo DECIMAL(10,2)
    );

    INSERT INTO #TempSaldos (Saldo)
    SELECT Saldos
    FROM GestorSaldo.dbo.Saldos
    ORDER BY Saldos DESC;

    SELECT @TotalGestores = COUNT(*) FROM GestorSaldo.dbo.Gestores;
    SELECT @TotalSaldos = COUNT(*) FROM GestorSaldo.dbo.Saldos;
    SET @Iteraciones = CEILING(CAST(@TotalSaldos AS FLOAT) / @TotalGestores);

    DECLARE gestorCursor CURSOR FOR
        SELECT ID, Gestores
        FROM GestorSaldo.dbo.Gestores;

    WHILE @IteracionActual <= @Iteraciones
        BEGIN
            OPEN gestorCursor;
            SET @GestorIndex = 1;

            -- Asignación saldos a cada gestor
            WHILE @GestorIndex <= @TotalGestores AND @SaldoIndex <=@TotalSaldos
                BEGIN
                    FETCH NEXT FROM gestorCursor INTO @GestorId, @GestorNombre;
                    IF @@FETCH_STATUS != 0
                        BEGIN
                            CLOSE gestorCursor;
                            OPEN gestorCursor;
                            FETCH NEXT FROM gestorCursor INTO @GestorId, @GestorNombre;
                        END

                    SELECT @Saldo = Saldo FROM #TempSaldos WHERE ID = @SaldoIndex;

                    INSERT INTO #TempAsignaciones (Gestores, Saldos)
                    VALUES (@GestorNombre, @Saldo);

                    SET @GestorIndex = @GestorIndex + 1;
                    SET @SaldoIndex= @SaldoIndex + 1;
                END

            CLOSE gestorCursor;

            SET @IteracionActual = @IteracionActual + 1;
        end
    DEALLOCATE gestorCursor;
    select * from #TempAsignaciones
END;
