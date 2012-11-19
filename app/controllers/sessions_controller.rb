class SessionsController < Devise::SessionsController

  def new
  	super
  end

  def create
  	super
  end
	
  def destroy
  	guest_user.destroy unless guest_user.nil?
    cookies.delete :uuid
    super
  end

end