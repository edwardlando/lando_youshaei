class StaticPagesController < ApplicationController
	layout "no_header_footer"

	def about
	end

	def tastemakers 
		@top_contributors = User.all.sort { |a, b| b.items.count <=> a.items.count } 
		@top_rated = User.all.sort { |a, b| b.rating <=> a.rating} 
	end

	def contact
	end

	def terms
    end

    def privacy
    end

    def jobs
    end
end
