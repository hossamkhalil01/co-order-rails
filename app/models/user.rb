class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :github]

  # Relationship with orders
  has_many :orders, class_name: "Order", foreign_key: :owner_id, dependent: :destroy 
  
  # Relationship with group
  has_many :groups , dependent: :destroy

  # Relationship with friends (self join)
  has_many :friends, dependent: :destroy
  has_many :friends, through: :friends

  #Relation of user to photo
  has_one :user_images

  #mount image column to image directory
  mount_uploader :image, PictureUploader


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      print auth.info
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.last_name = auth.info.name   
      user.image = auth.info.image 
      # skiping eamil confirmation when use the providers  
      user.skip_confirmation!
      user.save!
      
  end
end

end
