class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_request = CatRentalRequest.all
    render :index
  end

  def show
    @request = CatRentalRequest.find_by_id(params[:id])
    @cat = Cat.find(@request.cat_id)
    render :show
  end

  def new
    @cats = Cat.all
    render :new
  end

  def create
    c = CatRentalRequest.create!(params[:cat_rental_request])

    redirect_to cat_rental_request_url(c)
  end

  def edit
    @cat_rental_request = CatRentalRequest.find(params[:id])
    render :edit
  end

  def update
    crr = CatRentalRequest.find(params[:id])
    #c.update_attributes(params[:cat_rental_request])
    crr.approve

    redirect_to cat_url(crr.cat)
  end
end
