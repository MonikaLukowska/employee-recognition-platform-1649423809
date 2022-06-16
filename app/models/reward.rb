class Reward < ApplicationRecord
  has_many :orders, dependent: :nullify

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
end
