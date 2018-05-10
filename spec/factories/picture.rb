FactoryBot.define do
  factory :picture do
    file { File.open("#{Rails.root}/spec/fixtures/rails-logo.png") }
  end
end
