//= require jquery
//= require jquery-ui
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap
//= require bootstrap-datepicker/dist/js/bootstrap-datepicker
//= require typeahead.js/dist/typeahead.bundle
//= require momentjs/moment
//= require locationpicker
//= require googlemap
//= require chat
//= require turbolinks
//= require nprogress
//= require nprogress-turbolinks
//= require tooltip

$(function(){
  $('#quote-carousel').carousel({
    pause: true,
    interval: 4000,
  });

  // datepicker search group
  var dp_opts = {
    startDate: "new Date()",
    autoclose: true,
    todayHighlight: true,
    format: "yyyy-mm-dd"
  }

  var dp_from = $('.datepicker_from').datepicker(dp_opts);
  var dp_to = $('.datepicker_to').datepicker(dp_opts);

  dp_from.on("changeDate", function(selectedDate){
    dp_to.removeAttr('disabled');

    dp_to.datepicker("setStartDate", selectedDate.date);
  });

  dp_from.on("clearDate", function(){
    dp_to.attr('disabled', true);
    dp_to.val('');
  })

  // datepicker edit profile
  $('.datepicker').datepicker({ todayHighlight: true });
  
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
    var country = $(this).val();

    if (country !== '') {
      $.ajax({
        url: "/sync/get_provinces",
        cache: false,
        data: {
          country: country
        }
      });

		  $('.province-dropdown').removeAttr('disabled');
    }else{
      console.log('helo')
      $('.province-dropdown').attr('disabled', 'true');
      $('.city-dropdown').attr('disabled', 'true');
    }
  });
  
  $(".province-dropdown").on("change", function(){
    var province =  $(this).val();

    $.ajax({
      url: "/sync/get_cities",
      cache: false,
      data: {
        province: province
      }
    });

    $('.city-dropdown').removeAttr('disabled');
  });

  var numbers = new Bloodhound({
    remote: {
      url: "/groups/autocomplete?query=%QUERY",
      wildcard: '%QUERY'
    },
    datumTokenizer: function(g) { 
            return Bloodhound.tokenizers.whitespace(g.name); },
    queryTokenizer: Bloodhound.tokenizers.whitespace
  });

  var promise = numbers.initialize();

    // instantiate the typeahead UI
  $('.typeahead').typeahead(null, {
    displayKey: 'name',
    source: numbers.ttAdapter()
  });

  $('.typeahead').on('typeahead:selected', function(event, datum) {
    $("#group_id").val(datum.value);
  });

  moment.locale('id');

  var time = $('.timetostr').html();
  var toStr = $('.timetostr').html(moment(new Date(time)).format('ddd, DD MMM YYYY'))
});
