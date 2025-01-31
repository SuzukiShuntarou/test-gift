# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :goal
end
