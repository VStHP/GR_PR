jQuery ->
  questions = $('#questions')

  questions.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn(700)

  questions.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(700)


  nested_element = $('#nested-attr')

  nested_element.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn(700)

  nested_element.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(700)

  nested_element_sub = $('#nested-attr-sub')

  nested_element_sub.on 'cocoon:before-insert', (e, el_to_add) ->
    el_to_add.fadeIn(700)

  nested_element_sub.on 'cocoon:before-remove', (e, el_to_remove) ->
    $(this).data('remove-timeout', 1000)
    el_to_remove.fadeOut(700)

