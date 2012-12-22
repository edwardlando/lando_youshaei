class StaticPagesController < ApplicationController
	layout "no_header_footer"

	def about
	end

	def tastemakers
		@tastemakers = User.find_all_by_role("tastemaker")
		@top_contributors = @tastemakers.sort_by { |t| t.items }
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
