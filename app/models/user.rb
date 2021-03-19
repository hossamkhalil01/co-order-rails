class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable

  # Relationship with orders
  has_many :orders, dependent: :destroy

  # Relationship with group
  has_many :groups , dependent: :destroy

  # Relationship with friends (self join)
  has_many :user_friends, dependent: :destroy
  has_many :friends, through: :user_friends

end
