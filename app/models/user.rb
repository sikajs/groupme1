class User < ActiveRecord::Base
  has_many :groups
  has_many :posts
  
  has_many :group_users
  has_many :participated_groups, :through => :group_users, :source => :group
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  
  #extend OmniauthCallbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
         :omniauth_providers => [:facebook, :github]
         
  def join!(group)
    participated_groups << group
  end
  
  def quit!(group)
    participated_groups.delete(group)
  end
  
  def is_member_of?(group)
    participated_groups.include?(group)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name= auth["info"]["name"]
    end
  end
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
    end
  end
end
