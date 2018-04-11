jQuery ->
  questions = $('#questions')

  questions.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn(700)

  questions.on 'cocoon:after-insert', (e, added_el) ->
    added_el.effect('highlight', {}, 500)

  questions.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(700)
