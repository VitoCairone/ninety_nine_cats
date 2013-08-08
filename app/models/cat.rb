class Cat < ActiveRecord::Base
  attr_accessible :age, :birth_date, :color, :name, :sex

  has_many :rental_requests,
  :dependent => :destroy,
  :class_name => "CatRentalRequest",
  :foreign_key => :cat_id,
  :primary_key => :id
end
