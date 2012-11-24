class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_or_guest_user 
  helper_method :guest_user 

  # if user is logged in, return current_user, else return guest_user
=begin
  def current_or_guest_user
    if current_user
      if cookies[:uuid]
        logging_in # Look at this method to see how handing over works
        guest_user.destroy unless guest_user.nil? # Stuff have been handed over. Guest isn't needed anymore.
        cookies.delete :uuid # The cookie is also irrelevant now
      end
      current_user
    else
      guest_user
    end
  end
=end

  def current_or_guest_user
    if current_user
      if cookies[:uuid]
        guest_user.delete unless guest_user.nil?
        cookies.delete :uuid
      end
      current_user
    elsif guest_user
      guest_user
    end
  end

  # find guest_user object associated with the current session,
  # creating one as needed

  # not creating guest user here...
  def guest_user
    User.find_by_lazy_id(cookies[:uuid]) unless cookies[:uuid].nil? #.nil? ? create_guest_user.lazy_id : cookies[:uuid])
  end

  # called (once) when the user logs in, insert any code your application needs
  # to hand off from guest_user to current_user.
  def logging_in
	  @guest_user = guest_user
	  @user = User.new(params[:user])
    # What should be done here is take all that belongs to user with lazy_id
    # matching current_user's uuid cookie... then associate them with current_user
  end    

  
  #maybe should make this provate, and not have it as get route
	def create_guest_user
    p params
    p "******************************************"
    uuid = rand(36**64).to_s(36)
    temp_email = "guest_#{uuid}@email_address.com"
    u = User.create(:email => temp_email, :lazy_id => uuid)
    c = Channel.new(:name => "My test channel", :color => params[:channel][:color], 
      :style => params[:channel][:style], :price => params[:channel][:price],
      :gender => params[:channel][:gender])
    c.current_channel = true
    c.guest_user_id = u.lazy_id
    c.item_index = 0
    c.save
    u.save(:validate => false)
    cookies[:uuid] = { :value => uuid, :path => '/', :expires => 5.years.from_now }
    u
    redirect_to root_path
  end

  private

	def current_cart
		Cart.find(session[:cart_id])
	rescue ActiveRecord::RecordNotFound
		cart = Cart.create
		session[:cart_id] = cart.id
		cart
	end

end
