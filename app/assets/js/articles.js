$(document).on('turbolinks:load', function(){

    //get form in ajax
    $('.get_form').on('ajax:success', function(event) {
      //get data from ajax
      let data = event.detail[0].body;
      //set data in page
      $('#results').html(data);
      //show modal form with getted data
      $('#form').modal('show');
      //delete deleted image from front
      $('.delete_image').click(function(){
        $(this).closest('div').remove();
      });
    //after saving article
    $('#form').on('ajax:success', function(event) {
      //hide form
      $('#form').modal('hide');
      //show error if the image is not validate
      if(event.detail[0].images != undefined) {
        alert(event.detail[0].images)
      }
    })
  });

  //delete specific article from front
  $('.delete_entry').on('ajax:success', function() {
    $(this).closest('.6u').fadeOut(3000);
    $(this).closest('ul').remove();
  });

  //work with "push-up" after success saving article
  if($('.notice').text() != '') {
    setTimeout(function(){
      $('.notice').slideToggle('slow')
    }, 1000)
  }

});