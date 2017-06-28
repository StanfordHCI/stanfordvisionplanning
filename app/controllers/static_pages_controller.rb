class StaticPagesController < ApplicationController
  require 'will_paginate/array'
  def home
    @idea = current_user.ideas.build     if logged_in?
    @recent_ideas = Idea.order( 'created_at DESC' ).take(30)
    @ideas = (Idea.all.sort {|a,b| a.votes_value <=> b.votes_value}.reverse)
    @recent_ideas.each do |ri| 
    	if rand(3) == 0
    		@ideas = @ideas-[ri]
			@ideas = @ideas.insert(rand(@ideas.length/2), ri)    		
    	end
    end

  end
  def faq
  end
end
