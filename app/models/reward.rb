class Reward < ApplicationRecord
  has_many :orders, dependent: :nullify

  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }

  scope :paginate, ->(page, per_page) { Reward.limit(per_page).offset((page - 1) * per_page) }
end
