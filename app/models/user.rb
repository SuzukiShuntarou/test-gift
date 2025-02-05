# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :groups, dependent: :destroy
  has_many :rewards, through: :groups
  has_many :goals, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likings, dependent: :destroy
end
