defmodule Test.Schema.Helpers do
  import Ecto.Query
  
  def account_phone_numbers(_, account_ids) do
    phone_numbers_query =
      from a in Test.Account,
      join: c in Test.Contact, on: c.paired_account_id == a.id,
      join: p in Test.PhoneNumber, on: p.contact_id == c.id,
      where: a.id in ^account_ids,
      select: %{id: a.id, phone_number: p}

    phone_numbers = Test.Repo.all(phone_numbers_query)

    Map.new(phone_numbers, fn phone_number -> {phone_number.id, phone_number.phone_number} end)
  end

  def account_email_addresses(_, account_ids) do
    email_addresses_query =
      from a in Test.Account,
      join: c in Test.Contact, on: c.paired_account_id == a.id,
      join: e in Test.EmailAddress, on: e.contact_id == c.id,
      where: a.id in ^account_ids,
      select: %{id: a.id, email_address: e}

    email_addresses = Test.Repo.all(email_addresses_query)

    Map.new(email_addresses, fn email_address -> {email_address.id, email_address.email_address} end)
  end

  def account_contacts(_, account_ids) do
    contacts_query =
      from c in Test.Contact,
      where: c.account_id in ^account_ids,
      order_by: [c.first_name, c.last_name],
      select: %{id: c.account_id, contact: c}

    contacts = Test.Repo.all(contacts_query)
    contacts
    |> Enum.group_by(fn contact -> contact.id end, fn contact -> contact.contact end)
    |> Map.new(fn {account_id, group_of_contacts} -> {account_id, group_of_contacts} end)
  end
end