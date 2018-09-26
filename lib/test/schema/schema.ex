defmodule Test.Schema do
  use Absinthe.Ecto, repo: Test.Repo
  use Absinthe.Schema
  
  query do
    @desc "Get all customer accounts and customer contacts. Use for the customers list."
    field :customers, list_of(:customer) do
      resolve &Test.CustomerResolver.customers/2
    end
  end

  object :customer_account do
    field :id, :id
    field :name, :string
    field :phone_numbers, list_of(:phone_number) do
      resolve fn account, _, _ ->
        batch({Test.Schema.Helpers, :account_phone_numbers, PhoneNumber}, account.id, fn batch_results ->
          {:ok, Map.get(batch_results, account.id, [])}
        end)
      end
    end
    field :email_addresses, list_of(:email_address) do
      resolve fn account, _, _ ->
        batch({Test.Schema.Helpers, :account_email_addresses, EmailAddress}, account.id, fn batch_results ->
          {:ok, Map.get(batch_results, account.id, [])}
        end)
      end
    end
    field :contacts, list_of(:customer_contact) do
      resolve fn account, _, _ ->
        batch({Test.Schema.Helpers, :account_contacts, Contact}, account.id, fn batch_results ->
          {:ok, Map.get(batch_results, account.id, [])}
        end)
      end
    end
  end

  object :customer_contact do
    field :id, :id
    field :account, :customer_account#, resolve: assoc(:account)
    field :first_name, :string
    field :last_name, :string
    field :phone_numbers, list_of(:phone_number), resolve: assoc(:phone_numbers)
    field :email_addresses, list_of(:email_address), resolve: assoc(:email_addresses)
  end

  union :customer do
    types [:customer_account, :customer_contact]
    resolve_type fn
      %Test.Account{}, _ -> :customer_account
      %Test.Contact{}, _ -> :customer_contact
    end
  end

  object :phone_number do
    field :id, :id
    field :contact_id, :id
    field :carrier_type, :string
    field :label, :string
    field :number, :string
    field :primary, :boolean
  end

  object :email_address do
    field :id, :id
    field :contact_id, :id
    field :label, :string
    field :address, :string
    field :primary, :boolean
  end
end