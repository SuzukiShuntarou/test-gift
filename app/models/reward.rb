class Reward < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :users, through: :groups
  has_many :goals, dependent: :destroy

  accepts_nested_attributes_for :goals, allow_destroy: true
end
