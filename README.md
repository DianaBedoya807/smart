# Mnesia VS PostgreSQL

Este proyecto está desarrollado en Elixir y tiene como objetivo comparar el rendimiento y las características de las bases de datos Mnesia y PostgreSQL. Para ello, se implementan acciones de inserción y consulta en las tablas Students y Teacher utilizando ambas bases de datos. El propósito principal es determinar cuál de las dos es más eficiente y analizar las ventajas y desventajas específicas en dichas operaciones.

## Preparativos Antes de Iniciar
El primer paso es iniciar la imagen de Docker para habilitar la visualización y creación de métricas en **Grafana** y **Prometheus**. Para ello, ejecuta el comando ```docker-compose up -d``` en una terminal Bash desde la raíz del directorio. En esta ubicación se encuentra el archivo ```docker-compose.yml```,  que contiene la configuración necesaria para los servicios.

<img width="1350" alt="Captura de pantalla 2025-01-14 a la(s) 8 09 18 a m" src="https://github.com/user-attachments/assets/b5efb56a-7510-4f8b-b7c2-fae80e3b6768" />

Una vez que el comando se haya ejecutado, valida que las imágenes estén en ejecución utilizando el comando ```docker ps```. Este comando mostrará la lista de los contenedores activos, permitiéndote confirmar que los servicios se han iniciado correctamente.

<img width="1124" alt="Captura de pantalla 2025-01-14 a la(s) 8 31 20 a m" src="https://github.com/user-attachments/assets/189dfe61-b313-490c-965a-7a534b11131d" />

## Ejecutar Aplicativo
Después de la configuración, debemos instalar las dependencias definidas en el archivo **mix.exs** ejecutando el comando ```mix deps.get```. Luego, compilamos el proyecto para asegurarnos de que todo esté listo para ejecutarse con ```mix compile```. Finalmente, iniciamos el entorno interactivo de IEx y ejecutamos el proyecto con las configuraciones definidas mediante el comando ```iex -S mix```.

<img width="829" alt="Captura de pantalla 2025-01-14 a la(s) 9 04 34 a m" src="https://github.com/user-attachments/assets/ab761f7a-fd49-4782-ad62-597211c4a95b" />

## Colección de Archivos JSON
Este proyecto incluye una colección de archivos JSON que contienen datos de ejemplo y configuraciones utilizadas por la aplicación. 

[Collection_Smart.json](https://github.com/user-attachments/files/18411260/Collection_Smart.json){
	"info": {
		"_postman_id": "decb53cb-7c59-4aef-a173-d042e2db85fa",
		"name": "Elixir",
		"schema": "https://schema.getpostman.com/json/collection/v2.0.0/collection.json",
		"_exporter_id": "40345303"
	},
	"item": [
		{
			"name": "insert student",
			"request": {
				"method": "POST",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"data\": {\r\n        \"name\": \"Adolfo\",\r\n        \"lastname\": \"Sanchez \",\r\n        \"numberId\": \"43678890\",\r\n        \"age\": 25,\r\n        \"gender\": \"M\",\r\n        \"address\": \"Calle 23\",\r\n        \"email\": \"gsanchez@hotmail.com\",\r\n        \"phone\": \"3001234456\"\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": "http://localhost:8083/api/insert"
			},
			"response": []
		},
		{
			"name": "insert teacher",
			"request": {
				"method": "POST",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"data\": {\r\n        \"name\": \"Liliana\",\r\n        \"lastname\": \"Bernal\",\r\n        \"numberid\": \"23567890\",\r\n        \"age\": 45,\r\n        \"gender\": \"F\",\r\n        \"address\": \"Calle 71A\",\r\n        \"email\": \"libernal@gmail.com\",\r\n        \"phone\": \"3189023940\"\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": "http://localhost:8083/api/insertteacher"
			},
			"response": []
		},
		{
			"name": "select student",
			"request": {
				"method": "POST",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"data\": {\r\n        \"numberId\": \"43678890\"\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": "http://localhost:8083/api/getstudent"
			},
			"response": []
		},
		{
			"name": "select teacher",
			"request": {
				"method": "POST",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "{\r\n    \"data\": {\r\n        \"numberid\": \"1040737022\"\r\n    }\r\n}",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": "http://localhost:8083/api/getteacher"
			},
			"response": []
		},
		{
			"name": "metrics",
			"protocolProfileBehavior": {
				"disableBodyPruning": true
			},
			"request": {
				"method": "GET",
				"header": [],
				"body": {
					"mode": "raw",
					"raw": "",
					"options": {
						"raw": {
							"language": "json"
						}
					}
				},
				"url": "http://localhost:9568/metrics"
			},
			"response": []
		}
	]
}


