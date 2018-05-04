require 'ffaker'

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email 'foo@bar.com'
    password 'foobar'
  end
end