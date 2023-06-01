class Reward < ApplicationRecord
  has_many :orders, dependent: :nullify
  belongs_to :category, optional: true
  has_one_attached :photo

  validates :title, :description, :price, presence: true
  validates :title, uniqueness: true
  validates :price, numericality: { greater_than_or_equal_to: 1 }
  validate :correct_photo_type

  private

  def correct_photo_type
    return unless photo.attached? && !photo.content_type.in?(%w[image/png image/jpg image/jpeg])

    errors.add(:photo, 'Must be a png or jpg type')
  end
end
