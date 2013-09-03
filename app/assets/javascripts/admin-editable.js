$(function() {

  $('[data-zen-editable]').click(function(evt) {
    var target = $(evt.target),
        content = target.prop('outerHTML'),
        editId = target.attr('data-zen-id');

    var div = $('<div />').attr({ 'data-zen-id': editId }),
        field = $('<input />').attr({ 'type': 'text' }),
        save = $('<a>Save</a>').attr({ 'onclick': 'console.log(\'z\')' }),
        cancel = $('<a>Cancel</a>').attr({ 'onclick': ';' });
        
    field.val(content);
    div.append(field)
       .append(save)
       .append(cancel);
    target.replaceWith(div);
  });

});
