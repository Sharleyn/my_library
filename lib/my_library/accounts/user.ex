defmodule MyLibrary.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :name, :string
    field :age, :integer

    has_many :loans, MyLibrary.Library.Loan
    has_many :borrowed_books, through: [:loans, :book]


    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
  end
end
