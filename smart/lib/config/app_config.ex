defmodule Smart.Config.AppConfig do

  @moduledoc """
   Provides strcut for app-config
  """

   defstruct [
     :enable_server,
     :http_port,
     :database,
     :username,
     :password,
     :hostname,
     :port
   ]

   def load_config do
     %__MODULE__{
       enable_server: load(:enable_server),
       http_port: load(:http_port),
       database: load(:database),
       username: load(:username),
       password: load(:password),
       hostname: load(:hostname),
       port: load(:port)
     }
   end

   defp load(property_name), do: Application.fetch_env!(:smart, property_name)
 end
