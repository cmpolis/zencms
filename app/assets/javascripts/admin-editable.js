$(function() {

  $('[data-zen-editable]').click(function(evt) {
    var target = $(evt.target),
        content = $(target).clone(),
        editId = target.attr('data-zen-id'),
        layoutId = target.attr('data-zen-layout');

    content.attr({
      'data-zen-layout': null,
      'data-zen-editable': null,
      'data-zen-id': null
    });
    var div = $('<div />').attr({ 
                'data-zen-id': editId,
                'class': 'edit-box' }),
        field = $('<input />').attr({ 'type': 'text' }),
        save = $('<a>Save</a>').attr({ 'onclick': 'saveEdit(this,"'+layoutId+'","'+editId+'");' }),
        cancel = $('<a>Cancel</a>').attr({ 'onclick': 'cancelEdit(this);' });
        
    field.val(content.prop('outerHTML'));
    div.append(field)
       .append(save)
       .append(cancel);
    target.hide();
    div.insertAfter(target);
  });

  window.saveEdit = function(submit, layout, id) {
    var editBox = $(submit).parent('.edit-box'),
        content = editBox.find('input').val();
    $.ajax({
      type: 'POST',
      url: '/admin/edit',
      data: {
        layout_id: layout,
        content_id: id,
        content: content
      },
      success: function() { document.location.reload(); }
    });
  };

  window.cancelEdit = function(cancel) {
    var editBox = $(cancel).parent('.edit-box'),
        content = editBox.prev();
    editBox.remove();
    content.show().attr('style', null);
  };

});
