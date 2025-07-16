defmodule MyLibrary.Library.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias MyLibrary.Library.Loan

  schema "books" do
    field :title, :string
    field :author, :string
    field :isbn, :string
    field :published_at, :date

    has_many :loans, Loan
    has_many :borrowers, through: [:loans, :user]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(book, attrs) do
    book
    |> cast(attrs, [:title, :author, :isbn, :published_at])
    |> validate_required([:title, :author, :isbn, :published_at])

  end
end
