# Mnesia VS PostgreSQL
-------

Este proyecto está desarrollado en Elixir y tiene como objetivo comparar el rendimiento y las características de las bases de datos Mnesia y PostgreSQL. Para ello, se implementan acciones de inserción y consulta en las tablas Students y Teacher utilizando ambas bases de datos. El propósito principal es determinar cuál de las dos es más eficiente y analizar las ventajas y desventajas específicas en dichas operaciones.

## Antes de Iniciar
Lo primero que debemos hacer es iniciar la imagen de Docker de **Localstack** para habilitar la visualización y creación de métricas en **Grafana** y **Prometheus**. Para esto se debe ejecutar el comando: ```docker-compose up -d```
