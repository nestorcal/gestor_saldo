USE master;

-- Crear BD
IF NOT EXISTS (SELECT name from sys.databases where name='GestorSaldo')
    BEGIN
        CREATE DATABASE GestorSaldo;
        PRINT 'Base de datos GestorSaldo creado';
    END
ELSE
    BEGIN
        PRINT 'La base de datos GestorSaldo ya existe';
    END
GO

USE GestorSaldo;

-- Crear Tablas
IF NOT EXISTS (SELECT * from sysobjects WHERE name='Saldos')
    BEGIN
        CREATE TABLE Saldos(
            ID INT IDENTITY(1,1) PRIMARY KEY,
            Saldos DECIMAL(10,2) NOT NULL 
        );
        PRINT 'Tabla Saldos creada';
    END
ELSE
    BEGIN
        PRINT 'La Tabla Saldos ya existe';
    END
GO

IF NOT EXISTS (SELECT * from sysobjects WHERE name='Gestores')
    BEGIN
        CREATE TABLE Gestores(
            ID INT IDENTITY(1,1) PRIMARY KEY,
            Gestores VARCHAR(50) NOT NULL
        );
        PRINT 'Tabla Gestores creada';
    END
ELSE
    BEGIN
        PRINT 'La Tabla Gestores ya existe';
    END
GO

-- Insertar Datos
IF NOT EXISTS (SELECT TOP 1 1 FROM Saldos)
    BEGIN
        INSERT INTO Saldos(Saldos) VALUES (2277), (3953), (4726), (1414), (627), 
        (1784), (1634), (3958), (2156), (1347), (2166), (820), (2325),
        (3613), (2389), (4130), (2007), (3027), (2591), (3940), (3888),
        (2975), (4470), (2291), (3393), (3588), (3286), (2293), (4353),
        (3315), (4900), (794), (4424), (4505), (2643), (2217), (4193),
        (2893), (4120), (3352), (2355), (3219), (3064), (4893), (272),
        (1299), (4725), (1900), (4927), (4011);
        PRINT 'Datos insertados en Saldos';
    END
ELSE
    BEGIN
            PRINT 'La Tabla Saldos ya tiene Datos';
    END

-- DAtos Gestores
IF NOT EXISTS (SELECT TOP 1 1 FROM Gestores)
    BEGIN
        INSERT INTO Gestores(Gestores) VALUES ('Gestor1'), ('Gestor2'), ('Gestor3'), 
        ('Gestor4'), ('Gestor5'), ('Gestor6'), ('Gestor7'), ('Gestor8'),
        ('Gestor9'), ('Gestor10');
        PRINT 'Datos insertados en Gestores';
    END
ELSE
    BEGIN
                PRINT 'La Tabla Gestores ya tiene Datos';
    END