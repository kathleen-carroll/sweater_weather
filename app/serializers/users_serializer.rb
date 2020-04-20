class UsersSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email

  attribute :api_key do |object|
    object.password_digest
  end
end
