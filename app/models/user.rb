require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :username, :password, :session_token

  has_many :cats,
    :class_name => "Cat",
    :foreign_key => :owner_id,
    :primary_key => :id

  has_many :rental_requests,
    :class_name => "CatRentalRequest",
    :foreign_key => :user_id,
    :primary_key => :id

  def password=(password)
    # BCrypt docs at http://bcrypt-ruby.rubyforge.org/
    self.password_digest = BCrypt::Password.create(password)
  end

  def verify_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end


end
