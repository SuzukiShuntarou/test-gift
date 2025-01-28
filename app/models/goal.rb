class Goal < ApplicationRecord
  belongs_to :user
  belongs_to :reward
  has_many :favorites, dependent: :destroy
end
