defmodule Test.Contact do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :first_name, :last_name]}
  @primary_key {:id, :binary_id, autogenerate: true}

  schema "contacts" do
    field :external_id, :string
    field :revision, :integer
    belongs_to :paired_account, Test.Account, type: :binary_id
    belongs_to :paired_location, Test.Location, type: :binary_id
    belongs_to :paired_user, Test.User, type: :binary_id
    belongs_to :owner_account, Test.Account, type: :binary_id
    belongs_to :owner_location, Test.Location, type: :binary_id
    belongs_to :account, Test.Account, type: :binary_id
    belongs_to :location, Test.Location, type: :binary_id
    belongs_to :associated_user, Test.User, type: :binary_id
    has_many :phone_numbers, Test.PhoneNumber
    has_many :email_addresses, Test.EmailAddress
    field :type, :string
    field :first_name, :string
    field :last_name, :string
    field :inserted_at, Timex.Ecto.DateTime, read_after_writes: true
    field :inserted_by_user_id, :binary_id
    field :updated_at, Timex.Ecto.DateTime, read_after_writes: true
    field :updated_by_user_id, :binary_id
    field :deleted, :boolean
  end
end
