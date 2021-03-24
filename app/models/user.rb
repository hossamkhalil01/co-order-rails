class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2, :github]

  # Relationship with orders
  has_many :orders, class_name: "Order", foreign_key: :owner_id, dependent: :destroy 
  
  # Relationship with group
  has_many :groups, foreign_key: :owner_id, dependent: :destroy 

  # Relationship with friends (self join)
  has_many :friendships, dependent: :destroy
  has_many :friends, :through  => :friendships

  #mount image column to image directory
  mount_uploader :image, PictureUploader


  def self.from_omniauth(auth)
    binding.pry
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.last_name = auth.info.name   
      user.image = auth.info.image 
      # skiping eamil confirmation when use the providers  
      if user.image
      else
        user.image = "https://i.ibb.co/SK3QN1j/unknown-image.jpg"
      end

      user.skip_confirmation!
      user.save!
    rescue 
      $error_messges = user.errors.full_messages 
  end
end

end
