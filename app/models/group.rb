# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :user
  belongs_to :reward
end
