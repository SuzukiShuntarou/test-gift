# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :goal, counter_cache: :favorites_count
end
