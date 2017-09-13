// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require jquery3
//= require bootstrap-sprockets


$(document).on('turbolinks:load', function(){
  $('.alert').delay(2000).fadeOut(2000);
});

function showImages(el) {
    var windowHeight = jQuery( window ).height();
    $(el).each(function(){
        var thisPos = $(this).offset().top;

        var topOfWindow = $(window).scrollTop();
        if (topOfWindow + windowHeight - 300 > thisPos ) {
            $(this).addClass("fadeIn");
        }
    });
}
// if the image in the window of browser when the page is loaded, show that image
$(document).ready(function(){
        showImages('.project');
});

// if the image in the window of browser when scrolling the page, show that image
$(window).scroll(function() {
        showImages('.project');
});


$.getScript('//cdn.jsdelivr.net/isotope/1.5.25/jquery.isotope.min.js',function(){

  /* activate jquery isotope */
  $('#projects').imagesLoaded( function(){
    $('#projects').isotope({
      itemSelector : '.item'
    });
  });
  
});