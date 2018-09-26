defmodule TestWeb.Router do
  use TestWeb, :router
  require Logger

  pipeline :browser do
    plug :accepts, ["html"]
    plug :plug_before_send
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  forward "/api", Absinthe.Plug,
    schema: Test.Schema,
    before_send: {__MODULE__, :absinthe_before_send}

  forward "/graphiql", Absinthe.Plug.GraphiQL,
    schema: Test.Schema,
    before_send: {__MODULE__, :absinthe_before_send}

  scope "/", TestWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  def absinthe_before_send(conn, _) do
    {:memory, memory} = :erlang.process_info(self(), :memory)
    Logger.info("Memory Before Absinthe Send: #{memory}")
    conn
  end

  def plug_before_send(conn, _) do
    Plug.Conn.register_before_send(conn, fn conn ->
      {:memory, memory} = :erlang.process_info(self(), :memory)
      Logger.info("Memory Before Plug Send: #{memory}")
      conn
    end)
  end
end
