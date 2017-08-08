class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]

  has_many :posts
  has_many :comments
  
  # Virtual attribute for authenticating by either phonenumber or email
  # This is in addition to a real persisted field like 'phonenumber'
  attr_accessor :login
  
def self.find_for_database_authentication(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(phonenumber) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    where(conditions).first
  end
end

def self.find_first_by_auth_conditions(warden_conditions)
  conditions = warden_conditions.dup
  if login = conditions.delete(:login)
    where(conditions).where(["lower(phonenumber) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  else
    if conditions[:phonenumber].nil?
      where(conditions).first
    else
      where(phonenumber: conditions[:phonenumber]).first
    end
  end
end
    
  
end
