class Recipe < ApplicationRecord
  validates :name, :description, :ingredients, :directions, presence: true
  belongs_to :user
end
