defmodule Test.Location do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "locations" do
    field :revision, :integer
    belongs_to :account, Test.Account, type: :binary_id
    has_one :contact, Test.Contact, foreign_key: :paired_location_id
    many_to_many :users, Test.User, join_through: "users_locations"
    field :name, :string
    field :street, :string
    field :locality, :string
    field :region, :string
    field :postal_code, :string
    field :country, :string
    field :position, :integer
    field :message_received_template, :string
    field :message_read_template, :string
    field :timezone, :string
    field :away_message_enabled, :boolean
    field :away_message_text, :string
    field :away_message_template, :string
    field :inserted_at, Timex.Ecto.DateTime, read_after_writes: true
    field :inserted_by_user_id, :binary_id
    field :updated_at, Timex.Ecto.DateTime, read_after_writes: true
    field :updated_by_user_id, :binary_id
    field :deleted, :boolean
  end
end
