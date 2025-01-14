# Mnesia VS PostgreSQL
-------

Este proyecto está desarrollado en Elixir y tiene como objetivo comparar el rendimiento y las características de las bases de datos Mnesia y PostgreSQL. Para ello, se implementan acciones de inserción y consulta en las tablas Students y Teacher utilizando ambas bases de datos. El propósito principal es determinar cuál de las dos es más eficiente y analizar las ventajas y desventajas específicas en dichas operaciones.

## Antes de Iniciar
El primer paso es iniciar la imagen de Docker para habilitar la visualización y creación de métricas en **Grafana** y **Prometheus**. Para ello, ejecuta el comando ```docker-compose up -d``` en una terminal Bash desde la raíz del directorio. En esta ubicación se encuentra el archivo ```docker-compose.yml```,  que contiene la configuración necesaria para los servicios.

<img width="1350" alt="Captura de pantalla 2025-01-14 a la(s) 8 09 18 a m" src="https://github.com/user-attachments/assets/b5efb56a-7510-4f8b-b7c2-fae80e3b6768" />

Una vez que el comando se haya ejecutado, valida que las imágenes estén en ejecución utilizando el comando ```docker ps```. Este comando mostrará la lista de los contenedores activos, permitiéndote confirmar que los servicios se han iniciado correctamente.

<img width="1124" alt="Captura de pantalla 2025-01-14 a la(s) 8 31 20 a m" src="https://github.com/user-attachments/assets/189dfe61-b313-490c-965a-7a534b11131d" />




