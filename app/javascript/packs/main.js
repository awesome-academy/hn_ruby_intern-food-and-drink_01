console.log("main")
;(function ($) {
  'use strict'

  // Dropdown on mouse hover
  $(document).ready(function () {
    function toggleNavbarMethod () {
      if ($(window).width() > 992) {
        $('.navbar .dropdown')
          .on('mouseover', function () {
            $('.dropdown-toggle', this).trigger('click')
          })
          .on('mouseout', function () {
            $('.dropdown-toggle', this)
              .trigger('click')
              .blur()
          })
      } else {
        $('.navbar .dropdown')
          .off('mouseover')
          .off('mouseout')
      }
    }
    toggleNavbarMethod()
    $(window).resize(toggleNavbarMethod)
  })

  // Back to top button
  $(window).scroll(function () {
    if ($(this).scrollTop() > 100) {
      $('.back-to-top').fadeIn('slow')
    } else {
      $('.back-to-top').fadeOut('slow')
    }
  })
  $('.back-to-top').click(function () {
    $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo')
    return false
  })
})(jQuery)

$(document).on('turbolinks:load', function(){
  $('.select-status').on('focusin', function(){
    $(this).data('val', $(this).val());
  });

  $(".select-status").on("change",function(event) {

    event.preventDefault();
    var prev = $(this).data('val');
    console.log("here")
    var button = $(this)
    var state = $(this).val();
    var id_this = this.id
    if(state != "canceled") {
      if(!confirm('Are you sure?')){
        console.log(prev)
        console.log(id_this)
        $('#'+id_this).val(prev);
        return;
      }
      this.form.submit();
    }
    else{
      console.log(state)
      $("div#reason-modal_" + this.id).modal();
    }
  })

  // Product Quantity
  $('.quantity button').on('click', function () {
    console.log("click")
    var button = $(this)
    var oldValue = button
      .parent()
      .parent()
      .find('#number_product')
      .val()
      console.log(oldValue)
    if (button.hasClass('btn-plus')) {
      console.log("plus")
      var newVal = parseFloat(oldValue) + 1
    } else {
      if (oldValue > 1) {
        var newVal = parseFloat(oldValue) - 1
      } else {
        newVal = 1
      }
    }
    button
      .parent()
      .parent()
      .find('#number_product')
      .val(newVal)
  })
})
