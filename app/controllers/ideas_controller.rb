class IdeasController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
  def create
    @idea = current_user.ideas.build(idea_params)
    if @idea.save
      forum_messageboard = Thredded::Messageboard.find_by(name: "Ideas")
      
      if forum_messageboard != nil
		new_topic = Thredded::TopicForm.new(user: current_user, messageboard: forum_messageboard, title: @idea.content, content: "Vote on the idea here: "+root_url)
      	new_topic.save
      	
      end
      topic = Thredded::Topic.find_by(title: @idea.content)
      @idea.thredded_topic = topic
      @idea.save
      flash[:success] = "idea created!" 
      redirect_to root_url
    else
      @ideas = Idea.all.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end
  
  def update
    idea = Idea.find(params[:id])
    vote = idea.votes.find_or_initialize_by(user: current_user)
    
    if vote.value == params[:value].to_i
      vote.destroy
    else
      vote.value = params[:value]
      vote.save
    end
    
    voted = vote.destroyed? ? 0 : vote.value
    render json: { upvotes: idea.upvotes, downvotes: idea.downvotes,
        voted: voted}
  end

  def destroy
    @idea.destroy
    flash[:success] = "Idea deleted"
    redirect_to request.referrer || root_url
  end
  def index
  	redirect_to root_url
  end

  private

    def idea_params
      params.require(:idea).permit(:content)
    end
    def correct_user
      @idea = current_user.ideas.find_by(id: params[:id])
      redirect_to root_url if @idea.nil?
    end
end
