ready = ->
    MAX_IDEA_CHARS = 140
    
    $('.vote-action-container').on 'ajax:success', '.vote-action', (e, data) ->
        $container = $(this).parent()
        
        changeVote = (type, value) ->
            $voteCount = $container.find ".#{type} > .vote-count"
            $voteCount.text data["#{type}s"]
            
            if parseInt(data.voted) is value
                $voteCount.parent().addClass('voted')
            else
                $voteCount.parent().removeClass('voted')
        
        changeVote 'upvote', 1
        changeVote 'downvote', -1
        
    
    $('.vote-action-container').on 'ajax:error', '.vote-action', ->
        document.location.href = '/users/sign_in'

    $('#idea_description').keydown ->
        updateCountdown = =>
            chars = $.trim($(this).val()).split(/\s+/).join(' ')
            numCharsLeft = MAX_IDEA_CHARS - chars.length
            $('#idea-countdown').text "#{numCharsLeft}"
        setTimeout updateCountdown, 0

$(document).on 'ready page:load', ready
