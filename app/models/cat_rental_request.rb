#require_relative 'cat.rb'

class CatRentalRequest < ActiveRecord::Base
  attr_accessible :cat_id, :begin_date, :end_date, :status

  belongs_to :cat,
  :class_name => "Cat",
  :foreign_key => :cat_id,
  :primary_key => :id

  validate :dates_must_be_ordered
  validate :cannot_request_rented_cat

  def approve
    cat = Cat.find(self.cat_id)
    raise 'request was not undecided' unless self.status == 'undecided'

    self.status = 'approved'
    self.save!

    cat.rental_requests.each do |request|
      next if request == self
      if self.overlaps?(request)
        request.status = 'denied'
        request.save!
      end
    end
  end

  def overlaps?(other_req)
    self.begin_date.between?(other_req.begin_date, other_req.end_date) ||
    self.end_date.between?(other_req.begin_date, other_req.end_date)
  end

  def dates_must_be_ordered
    if self.end_date < self.begin_date
      errors.add(:base, "end date cannot be < start date")
    end
  end

  def cannot_request_rented_cat
    return if self.status == 'denied'
    Cat.find(self.cat_id).rental_requests.each do |request|
      next if self == request
      if (self.overlaps?(request) && request.status == "approved")
        errors.add(:base, "can't request a rented cat")
      end
    end
  end

end
