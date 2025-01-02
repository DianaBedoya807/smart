# Usa una imagen base de Elixir
FROM elixir:1.14.5-alpine

# Instala dependencias necesarias
RUN apk add --no-cache build-base git

# Instalar Hex y Rebar (herramientas necesarias para manejar dependencias de Elixir)
RUN mix local.hex --force
RUN mix local.rebar --force

# Configuración de la app
WORKDIR /app
COPY . .

# Instalar dependencias
RUN mix deps.get
RUN mix compile

# Expone los puertos
EXPOSE 4000
EXPOSE 9568

# Ejecuta la aplicación
CMD ["mix", "run", "--no-halt"]
