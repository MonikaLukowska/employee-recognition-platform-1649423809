class Order < ApplicationRecord
  belongs_to :reward
  belongs_to :employee
end
