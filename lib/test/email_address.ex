defmodule Test.EmailAddress do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "email_addresses" do
    field :revision, :integer
    belongs_to :contact, Test.Contact, type: :binary_id
    field :label, :string
    field :address, :string
    field :primary, :boolean
    field :position, :integer
    field :inserted_at, Timex.Ecto.DateTime, read_after_writes: true
    field :inserted_by_user_id, :binary_id
    field :updated_at, Timex.Ecto.DateTime, read_after_writes: true
    field :updated_by_user_id, :binary_id
    field :deleted, :boolean
  end
end