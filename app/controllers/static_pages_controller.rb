class StaticPagesController < ApplicationController
  def home
    @idea = current_user.ideas.build if logged_in?
    @ideas = Idea.all.paginate(page: params[:page])
  end
  def faq
  end
end
