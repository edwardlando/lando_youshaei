module ApplicationHelper
	def current_channel
		# to be changed
		current_user.channels.first
	end
end
