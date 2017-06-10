class StaticPagesController < ApplicationController
  require 'will_paginate/array'
  def home
    @idea = current_user.ideas.build     if logged_in?
    @recent_ideas = Idea.order( 'created_at DESC' ).take(3)
    @ideas = (Idea.all.sort {|a,b| a.votes_value <=> b.votes_value}.reverse-@recent_ideas).paginate(page: params[:page])
  end
  def faq
  end
end
