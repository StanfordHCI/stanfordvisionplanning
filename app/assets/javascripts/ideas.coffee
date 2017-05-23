ready = ->
    MAX_IDEA_CHARS = 140
    
    $('.vote-action').on 'ajax:success', (e, data, status, xhr) ->
        alert "The article was deleted."
 
        
    
    $('.vote-action').on 'ajax:error', ->
        alert "The article was deleted."
 
    $('#idea_content').keydown ->
        updateCountdown = =>
            chars = $.trim($(this).val()).split(/\s+/).join(' ')
            numCharsLeft = MAX_IDEA_CHARS - chars.length
            $('#idea-countdown').text "#{numCharsLeft}"
        setTimeout updateCountdown, 0

$(document).on 'ready page:load', ready
