# Setup Steps
1. mix deps.get
2. iex -S mix phx.server

# Reproduction Steps
1. Open GraphiQL Workspace at http://localhost:4000/graphiql
2. Run query: 

query customersQuery {
  customers {
    ... on CustomerAccount {
      id
      name
    }
    ... on CustomerContact {
      id
      firstName
      lastName
      phoneNumbers {
        id
        label
        number
      }
    }
  }
}

3. The response size here is 19770 bytes. And in the console I have:
	[info] Memory At Resolver Start: 68064
	[info] Memory Before Absinthe Send: 973408
4. So it seems like to generate this response it uses 45x the memory required for the formatted data. 

# Control Group

1. Open http://localhost:4000.
2. The response size here is 9800 bytes. And in the console I have:
	[info] Memory At Action Start: 21624
	[info] Memory Before Plug Send: 142784
3. So it seems here to generate the response it uses 12x the memory required for the formatted data.