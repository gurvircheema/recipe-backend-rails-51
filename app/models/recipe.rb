class Recipe < ApplicationRecord
  validates :name, :description, :ingredients, :directions, presence: true
end
