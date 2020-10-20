defmodule Theme01Web.ClockController do
  use Theme01Web, :controller

  alias Theme01.Clocking
  alias Theme01.Clocking.Clock

  action_fallback Theme01Web.FallbackController

  def create(conn, %{"clock" => clock_params, "userID" => user_id}) do
    with {:ok, %Clock{} = clock} <- Clocking.create_clock(clock_params, %{"user_id" => user_id}) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
      |> render("show.json", clock: clock)
    end
  end

  def show(conn, %{"userID" => userID}) do
    clocks = Clocking.list_clock(userID)
    render(conn, "index.json", clocks: clocks)
  end
end
