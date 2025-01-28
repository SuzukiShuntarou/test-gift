class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :reward
  has_one :favorite, dependent: :destroy
  has_one :cheering, dependent: :destroy
end
