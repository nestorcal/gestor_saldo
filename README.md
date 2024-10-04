# Asignación de Saldos a Gestores

## Descripción

Este proyecto tiene como objetivo la creación de un procedimiento almacenado en SQL Server para la asignar saldos a gestores.
Se tiene en cuenta lo siguiente
- Ordenar los saldos en orden descendente antes de asignarlos.
- Aignar los saldos uno por uno a cada gestor.
- Repetir el proceso hasta que todos los saldos estén asignados a los gestores.
- El número de iteraciones debe ser igual a la división redondeada hacia arriba del número de saldos por el número de gestores.

La validacion se hace desde el programa en C#

## Uso

1. Clonar el repositorio.
2. Abrir SQL Server Management Studio.
3. Ejecutar [script de creacion de BD y tablas](https://github.com/nestorcal/gestor_saldo/blob/master/crearBdTalas.sql) y el [script de procedimiento almacenado](https://github.com/nestorcal/gestor_saldo/blob/master/asignarSaldosGestores.sql) en el servidor.
4. Ejecutar el [programa en C#](https://github.com/nestorcal/gestor_saldo/tree/master/ConsoleApp1)
