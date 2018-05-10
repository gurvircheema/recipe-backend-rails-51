class Recipe < ApplicationRecord
  include PgSearch

  validates :name, :description, :ingredients, :directions, presence: true
  belongs_to :user
  has_many :pictures
  attr_accessor :pictures_data

  pg_search_scope :search_for, against: [:name, :description, :ingredients]

  def as_json(options)
    super({ only: [ :id, :name, :description, :ingredients, :directions,
                    :user_id, :created_bt, :updated_at ],
            include: :pictures
    }.merge(options))
  end
end
