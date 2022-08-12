class Category < ApplicationRecord
  has_many :rewards, dependent: :restrict_with_error

  validates :title, uniqueness: { case_sensitive: false }, presence: true
end
