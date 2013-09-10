$(function() {
  window.entityUp = function(el) {
    var div = $(el).closest('.entity');
    var ndx = div.index();
    if(ndx == 0) return;

    $($('.entity-list .entity').get(ndx - 1)).before(div);
  };

  window.entityDown = function(el) {
    var div = $(el).closest('.entity');
    var ndx = div.index();
    if(ndx == $('.entity-list .entity').length - 1) return;

    $($('.entity-list .entity').get(ndx + 1)).after(div);
  };

  window.entityRemove = function(el) {
    $(el).closest('.entity').remove();
  };

  window.addEntity = function(select) {
    var val = $(select).val(),
        label = $(select + ' option:selected').text(),
        proto = $('.entity-list .entity:first').clone();
    if($('[data-entity-id="'+val+'"]').length > 0) return;

    proto.find('input').attr('value', val);
    proto.find('.entity-name').text(label);
    $('.entity-list').append(proto);
  };
  
  $('#property_kind').change(function() {
    var val = $('#property_kind').val();
    $('.row.type-possible').toggle(val == 'enum');
  });

});
