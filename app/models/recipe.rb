class Recipe < ApplicationRecord
  validates :name, :description, :ingredients, :directions, presence: true
  belongs_to :user
  has_many :pictures
  attr_accessor :pictures_data

  def as_json(options)
    super({ only: [ :id, :name, :description, :ingredients, :directions,
                    :user_id, :created_bt, :updated_at ],
            include: :pictures
    }.merge(options))
  end
end
