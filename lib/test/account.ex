defmodule Test.Account do
  use Ecto.Schema
  import Ecto.Changeset
  
  @derive {Poison.Encoder, only: [:id, :name]}
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "accounts" do
    field :revision, :integer
    belongs_to :owner_account, Test.Account, type: :binary_id
    belongs_to :owner_location, Test.Location, type: :binary_id
    has_many :contacts, Test.Contact
    has_many :locations, Test.Location
    field :type, :string
    has_one :contact, Test.Contact, foreign_key: :paired_account_id
    field :name, :string
    field :subdomain, :string
    field :billing_street, :string
    field :billing_locality, :string
    field :billing_region, :string
    field :billing_postal_code, :string
    field :billing_country, :string
    field :inserted_at, Timex.Ecto.DateTime, read_after_writes: true
    field :inserted_by_user_id, :binary_id
    field :updated_at, Timex.Ecto.DateTime, read_after_writes: true
    field :updated_by_user_id, :binary_id
    field :deleted, :boolean
  end
end
