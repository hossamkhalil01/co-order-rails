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

  # Notifications
  has_many :notifications, as:   :recipient

  def full_name
    return "#{first_name} #{last_name}" if first_name || last_name
  end

  def self.search(param)
    param.strip!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.first_name_matches(param)
    matches('first_name', param)
  end

  def self.last_name_matches(param)
    matches('last_name', param)
  end

  def self.email_matches(param)
    matches('email', param)
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_user(users)
    users.reject { |user| user.id == self.id }
  end

  def friends_with?(id_of_friend)
    self.friends.where(id: id_of_friend).exists?
  end

  def self.from_omniauth(auth)
    binding.pry
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.name
      user.last_name = auth.info.name   
      # user.image = auth.info.image 
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
