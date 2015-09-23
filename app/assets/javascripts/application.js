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
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap


$(function(){
  $('#quote-carousel').carousel({
    pause: true,
    interval: 4000,
  });
  $(".dropdown").hover(            
            function() {
                $('.dropdown-menu', this).stop( true, true ).fadeIn("fast");
                $(this).toggleClass('open');
                $('b', this).toggleClass("caret caret-up");                
            },
            function() {
                $('.dropdown-menu', this).stop( true, true ).fadeOut("fast");
                $(this).toggleClass('open');
                $('b', this).toggleClass("caret caret-up");                
            });
  $(".country-dropdown").on("change", function(){
    var countryCode = $(this).val();

    $.ajax({
		  url: "/sync/get_provinces",
		  cache: false,
      data: {
        country_code: countryCode
      }
		});
		  
  });
  
  $(".province-dropdown").on("change", function(){
    var provinceCode =  $(this).val();

    $.ajax({
      url: "/sync/get_cities",
      cache: false,
      data: {
        province_code: provinceCode
      }
    });

  });

});


