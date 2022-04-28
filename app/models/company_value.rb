class CompanyValue < ApplicationRecord
  validates :title, uniqueness: true, presence: true
end
