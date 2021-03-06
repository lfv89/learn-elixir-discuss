defmodule Discuss.AuthController do
  use Discuss.Web, :controller
  plug Ueberauth

  alias Discuss.User

  def callback(%{ assigns: %{ ueberauth_auth: auth } } = conn, %{ "provider" => provider }) do
    user_params = %{ token: auth.credentials.token, email: auth.info.email, provider: provider }
    changeset = User.changeset(%User{}, user_params)

    signin(conn, changeset)
  end

  def signout(conn, _params) do
    conn |> configure_session(drop: true) |> redirect(to: topic_path(conn, :index))
  end

  defp signin(conn, changeset) do
    case find_or_insert_by_email(changeset) do
      { :error, _reason } -> conn |> put_flash(:error, "Error signing in") |> redirect(to: topic_path(conn, :index))
      { :ok, user } -> conn |> put_flash(:info, "Welcome back!") |> put_session(:user_id, user.id) |> redirect(to: topic_path(conn, :index))
    end
  end

  defp find_or_insert_by_email(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil -> Repo.insert(changeset)
      user -> { :ok, user }
    end
  end
end
