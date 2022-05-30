class CompanyValue < ApplicationRecord
  has_many :kudos, dependent: :restrict_with_error

  validates :title, uniqueness: { case_sensitive: false }, presence: true
end
