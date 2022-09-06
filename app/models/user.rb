class User < ApplicationRecord
  has_one_attached :image
  has_many :events, dependent: :destroy
  has_many :joins, dependent: :destroy
  has_many :comments, dependent: :destroy


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
