class SessionsController < Devise::SessionsController

  def new
  	super
    cookies[:aveece_user_id] = current_user.id unless current_user.nil?
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