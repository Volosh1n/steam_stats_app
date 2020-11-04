class Game < ApplicationRecord
  validates :name, presence: true

  has_many :statistics, dependent: :destroy
end
