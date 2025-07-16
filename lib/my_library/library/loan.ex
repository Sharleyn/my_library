defmodule MyLibrary.Library.Loan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "loans" do
    field :borrowed_at, :naive_datetime
    field :due_at, :naive_datetime
    field :returned_at, :naive_datetime

    belongs_to :user, MyLibrary.Accounts.User
    belongs_to :book, MyLibrary.Library.Book

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(loan, attrs) do
    loan
    |> cast(attrs, [:borrowed_at, :due_at, :returned_at, :user_id, :book_id])
    |> validate_required([:borrowed_at, :due_at, :user_id, :book_id])
    |> cast_assoc(:user)
    |> cast_assoc(:book)
  end
end
