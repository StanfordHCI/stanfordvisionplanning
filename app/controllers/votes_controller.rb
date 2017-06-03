class VotesController < ApplicationController
	def upvote
		respond_to do |format|
    		format.html
    	format.json
  		end
	end
	def downvote
	end
end
