require 'ffaker'

FactoryBot.define do
  factory :recipe do
    name        { FFaker::Lorem.word }
    description { FFaker::Lorem.paragraphs }
    ingredients { FFaker::Lorem.words }
    directions  { FFaker::HipsterIpsum.sentences }
  end
end
