defmodule AuthWeb.Helpers.Auth do
  def signed_in?(conn, _params) do
    user_id = Plug.conn.get_session(conn, :current_user_id)
    if user_id, do: !!Auth.Repo.get(Auth.Accounts.User, user_id)
  end
end
