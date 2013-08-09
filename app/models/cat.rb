class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex, :owner_id

  has_many :rental_requests,
  :dependent => :destroy,
  :class_name => "CatRentalRequest",
  :foreign_key => :cat_id,
  :primary_key => :id

  belongs_to :owner,
    :class_name => "User",
    :foreign_key => :owner_id,
    :primary_key => :id
end
