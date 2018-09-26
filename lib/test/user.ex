defmodule Test.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "users" do
    field :revision, :integer
    belongs_to :account, Test.Account, type: :binary_id
    many_to_many :locations, Test.Location, join_through: "users_locations", on_replace: :delete
    has_one :contact, Test.Contact, foreign_key: :paired_user_id
    field :internal, :boolean
    field :enabled, :boolean
    field :username, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :current_password, :string, virtual: true
    field :new_password, :string, virtual: true
    field :password_hash, :string
    field :stock_messages, {:array, :string}, read_after_writes: true
    field :notification_interval, :integer, read_after_writes: true
    field :last_login_at, Timex.Ecto.DateTime
    field :verification_token, :string
    field :verification_sent_at, Timex.Ecto.DateTime
    field :verification_accepted_at, Timex.Ecto.DateTime
    field :reset_password_token, :string
    field :reset_password_sent_at, Timex.Ecto.DateTime
    field :inserted_at, Timex.Ecto.DateTime, read_after_writes: true
    field :inserted_by_user_id, :binary_id
    field :updated_at, Timex.Ecto.DateTime, read_after_writes: true
    field :updated_by_user_id, :binary_id
  end
end