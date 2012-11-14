class SessionsController < Devise::SessionsController
	
  def destroy
    guest_user.destroy
    super
  end

end