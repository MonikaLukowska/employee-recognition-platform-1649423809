class CompanyValue < ApplicationRecord
  validates :title, uniqueness: { case_sensitive: false }, presence: true
end
