defmodule LogtestPhxWeb.PageController do
  use LogtestPhxWeb, :controller
  require Logger
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.



    Logger.debug("Debug message")
    Logger.info("Info message")
    Logger.warning("Warning message")
    IO.inspect("################################")

    render(conn, :home, layout: false)
  end
end
