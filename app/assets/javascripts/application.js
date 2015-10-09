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
//= require jquery-ui
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require locationpicker
//= require googlemap


$(function(){
  $('#quote-carousel').carousel({
    pause: true,
    interval: 4000,
  });
  $('.input-daterange').datepicker({

  }); 

  $('#us2').locationpicker({
    location: {latitude: 46.15242437752303, longitude: 2.7470703125}, 
    radius:0,
    inputBinding: {
          latitudeInput: $('#us2-lat'),
          longitudeInput: $('#us2-lon'),
          radiusInput:0,
          locationNameInput: $('#us2-address')
    },
    enableAutocomplete: true    
  }); 

  $("#myBtn").click(function() {
    $(this).after(
        '<div class="alert alert-success alert-dismissable">'+
            '<button type="button" class="close" ' + 
                    'data-dismiss="alert" aria-hidden="true">' + 
                '&times;' + 
            '</button>' + 
            'Post has created' + 
         '</div>');
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

  var numbers = new Bloodhound({
    remote: {
      url: "/groups/autocomplete?query=%QUERY",
      wildcard: '%QUERY'
    },
    datumTokenizer: function(g) { 
            return Bloodhound.tokenizers.whitespace(g.name_place); },
    queryTokenizer: Bloodhound.tokenizers.whitespace
  });

  var promise = numbers.initialize();

  promise
  .done(function() { console.log('success!'); })
  .fail(function() { console.log('err!'); });
  

  // instantiate the typeahead UI
  $( '.typeahead').typeahead(null, {
    displayKey: 'name_place',
    source: numbers.ttAdapter()
  });

  $('.typeahead').on('typeahead:selected', function(event, datum) {
    $("#trip_id").val(datum.value);
  });

  
});


