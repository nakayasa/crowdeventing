class Event < ApplicationRecord
  belongs_to :genre
  belongs_to :users
  has_many :joins, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy
end
