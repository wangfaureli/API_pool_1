defmodule Theme01Web.UserController do
  use Theme01Web, :controller

  alias Theme01.Acount
  alias Theme01.Acount.User

  action_fallback Theme01Web.FallbackController

  def index(conn, _params) do
    users = Acount.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Acount.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Acount.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Acount.get_user!(id)

    with {:ok, %User{} = user} <- Acount.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Acount.get_user!(id)

    with {:ok, %User{}} <- Acount.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end