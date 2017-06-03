module VotesHelper
  def vote_button_options idea, value
    vote_type = value > 0 ? 'upvote' : 'downvote'
    
    { remote: true, method: :patch, format: :json,
      id: "#{vote_type}-#{idea.id}",
      class: vote_classes(idea, value, vote_type) }
  end
  
  private
  def vote_classes idea, value, vote_type
    status_class = vote_status_class(idea: idea, value: value)
    "idea-#{idea.id} btn btn-#{vote_type} #{vote_type} #{status_class} vote-action"
  end
  
  def voted? conditions = {}
    logged_in? && current_user.votes.exists?(conditions)
  end
  
  def vote_status_class conditions = {}
    voted?(conditions) ? 'voted' : ''
  end
end
