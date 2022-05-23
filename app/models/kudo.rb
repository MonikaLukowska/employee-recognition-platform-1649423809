class Kudo < ApplicationRecord
  belongs_to :receiver, class_name: 'Employee', inverse_of: :received_kudos
  belongs_to :giver, class_name: 'Employee', inverse_of: :given_kudos
  belongs_to :company_value, inverse_of: :kudos

  validates  :title, :content, presence: true
  validate :number_of_available_kudos_cannot_be_less_than_zero

  def number_of_available_kudos_cannot_be_less_than_zero
    return unless giver.number_of_available_kudos.zero?

    errors.add(:number_of_available_kudos, 'You have no more avaialable kudos left')
  end
end
