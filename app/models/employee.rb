class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver', dependent: :destroy, inverse_of: :receiver
  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver', dependent: :destroy, inverse_of: :giver

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def earned_points
    received_kudos.count
  end
end
