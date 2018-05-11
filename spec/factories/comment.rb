require 'ffaker'

FactoryBot.define do
  factory :comment do
    body { FFaker::Lorem.sentence }
  end
end
