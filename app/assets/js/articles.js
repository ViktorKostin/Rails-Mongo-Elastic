$(window).ready(function(){
    //get form in ajax
    $('.get_form').bind('ajax:success', function(event) {
      //get data from ajax
      let data = event.detail[0];
      //set data in page
      $('#results').html(data);
      //show modal form with getted data
      $('#form').modal('show');
      //delete deleted image from front
      $('.delete_image').click(function(){
        $(this).closest('div').remove();
      });
  });

  //delete specific article from front
  $('.delete_entry').bind('ajax:success', function() {
    $(this).closest('.6u').fadeOut(3000);
    $(this).closest('ul').remove();
  });

  //work with "push-up" after success saving article
  if($('.notice').text() != '') {
    setTimeout(function(){
      $('.notice').slideToggle('slow')
    }, 3000)
  }
});