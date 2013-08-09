class CatsController < ApplicationController
  before_filter :ensure_logged_in

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @user = current_user
    @cat = Cat.find_by_id(params[:id])
    render :show
  end

  def new
    render :new
  end

  def create
    params[:cat][:owner_id] = 3
    c = Cat.create!(params[:cat])

    redirect_to cat_url(c)
  end

  def edit

    @cat = Cat.find(params[:id])

    puts ">>> Cat name is #{@cat.name}"

    render :edit
  end

  def update

    c = Cat.find(params[:id])
    unless c.owner == current_user
      flash[:notices] ||= []
      flash[:notices] << "You do not own this cat."
      redirect_to cat_url(c)
      return
    end

    puts "Cat is #{c} with id #{c.id}"
    puts "params are #{params}"
    c.update_attributes(params[:cat])
    puts "Now cat is #{c}"
    #c.save!

    redirect_to cat_url(c)
  end

  def destroy
    cat = Cat.find(params[:id])

    if cat.owner == current_user
      cat.destroy
      render :text => "You are a terrible person and should feel bad"
    else
      render :text => "Don't delete other people's cats!"
      # penalty_cat = current_user.cats.first
      # penalty_cat.destroy
    end
  end
end

# cats     GET    /cats(.:format)          cats#index
#          POST   /cats(.:format)          cats#create
#  new_cat GET    /cats/new(.:format)      cats#new
# edit_cat GET    /cats/:id/edit(.:format) cats#edit
#      cat GET    /cats/:id(.:format)      cats#show
#          PUT    /cats/:id(.:format)      cats#update
#          DELETE /cats/:id(.:format)      cats#destroy
