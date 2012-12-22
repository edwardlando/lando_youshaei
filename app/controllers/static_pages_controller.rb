class StaticPagesController < ApplicationController
	layout "no_header_footer"

	def about
	end

	def tastemakers
		@tastemakers = User.find_all_by_role("tastemaker", "admin") 
		@top_contributors = @tastemakers.sort { |a, b| b.items.count <=> a.items.count } 
		@top_rated = @tastemakers.sort { |a, b| b.rating <=> a.rating} 
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
