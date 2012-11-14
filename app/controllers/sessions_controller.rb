class SessionsController < Devise::SessionsController

  def new
  	super
  end

  def create
  	super
  end
	
  def destroy
    guest_user.destroy
    cookies.delete :uuid
    super
  end

end