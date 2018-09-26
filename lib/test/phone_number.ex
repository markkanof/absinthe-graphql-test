defmodule Test.PhoneNumber do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "phone_numbers" do
    field :revision, :integer
    belongs_to :contact, Test.Contact, type: :binary_id
    field :carrier_type, :string
    field :sms_carrier_username, :string
    field :sms_carrier_password, :string
    field :sms_polling_active, :boolean
    field :sms_last_message_received_at, Timex.Ecto.DateTime
    field :label, :string
    field :number, :string
    field :primary, :boolean
    field :position, :integer
    field :inserted_at, Timex.Ecto.DateTime, read_after_writes: true
    field :inserted_by_user_id, :binary_id
    field :updated_at, Timex.Ecto.DateTime, read_after_writes: true
    field :updated_by_user_id, :binary_id
    field :deleted, :boolean
  end
end