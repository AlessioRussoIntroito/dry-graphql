class User < Dry::Struct
  module Types
    include Dry.Types()
  end

  attribute :name, Types::Strict::String.optional.default(nil)
#   attribute :age, Types::Coercible::Integer
#   attribute :middle_name, Types::Coercible::String
#   attribute :names, Types::Array.of(Types::Strict::String)
#   attribute :languages, Types::Strict::String.enum('en', 'it', 'de')

  attribute :city, Types::Array.of(Types::Strict::String).optional.default(nil)
  attribute :state, Types::Array.of(Types::Strict::String).optional.default(nil)
  attribute :country, Types::Array.of(Types::Strict::String).optional.default(nil)
end

class UserType < User.graphql_type(base_class: GraphQL::Schema::Object, graphql_name: 'UserType')
  # you can add other fields here if you want
end

class UserInput < User.graphql_type(base_class: GraphQL::Schema::InputObject, graphql_name: 'UserInput')
end

class UserResolver < GraphQL::Schema::Resolver
  type UserType, null: true
  argument :filter, UserInput, required: false
  
  def resolve(filter:)
  end
end

class Query < GraphQL::Schema::Object
  field :user, resolver: UserResolver
end

class Schema < GraphQL::Schema
  query Query
end

puts GraphQL::Schema::Printer.print_schema(Schema)
