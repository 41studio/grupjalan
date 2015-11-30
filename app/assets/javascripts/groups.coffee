$(document).ready ->
  $('.input-comment, .panel-posts-comment .btn-close').on 'click', (event) ->
    $panel = $(this).closest('.panel-posts')
    $comment = $panel.find('.panel-posts-comment')
    $comment.find('textarea').val ''
    $panel.toggleClass 'panel-posts-show-comment'
    $panel.find('.input-comment').toggleClass 'hide'
    if $panel.hasClass('panel-posts-show-comment')
      $comment.find('textarea').focus()
    return
  $('.panel-posts-comment #comment_comment').on 'keyup', (event) ->
    $comment = $(this).closest('.panel-posts-comment')
    $comment.find('.btn-success').attr('disabled', '')
    if $(this).val().length >= 1
      $comment.find('.btn-success').removeAttr 'disabled'
    return
  return