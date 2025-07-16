defmodule MyLibrary.Repo do
  use Ecto.Repo,
    otp_app: :my_library,
    adapter: Ecto.Adapters.Postgres
end
