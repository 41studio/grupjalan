//= require jquery
//= require jquery-ui
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap
//= require bootstrap-datepicker/dist/js/bootstrap-datepicker
//= require typeahead.js/dist/typeahead.bundle
//= require momentjs/moment
//= require momentjs/locale/id
//= require locationpicker
//= require googlemap
//= require spinjs/spin
//= require chat
//= require nprogress
//= require nprogress-turbolinks
//= require tooltip
//= require groups
//= require spin.ajax
//= require turbolinks
//= require holder
//= require data-confirm-modal

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

  $('.timetostr').each(function(){
    var time = $(this).html();
    var toStr = $(this).html(moment(new Date(time)).format('ddd, DD MMM YYYY'))

    $(this).removeClass('timetostr');
  })

  $('.pribumi').on('change', function(){
    if($(this).is(':checked')) {
      $(".date_hide").parent().hide();  // checked
    } else {
      $(".date_hide").parent().show();  // unchecked
    }
  })

   $("#transition-timer-carousel").on("slide.bs.carousel", function(event) {
        //The animate class gets removed so that it jumps straight back to 0%
        $(".transition-timer-carousel-progress-bar", this)
            .removeClass("animate").css("width", "0%");
    }).on("slid.bs.carousel", function(event) {
        //The slide transition finished, so re-add the animate class so that
        //the timer bar takes time to fill up
        $(".transition-timer-carousel-progress-bar", this)
            .addClass("animate").css("width", "100%");
    });
    
    //Kick off the initial slide animation when the document is ready
    $(".transition-timer-carousel-progress-bar", "#transition-timer-carousel")
        .css("width", "100%");

    // Stop carousel
    $('.carousel').carousel();

    //minimum 8 characters
    var bad = /(?=.{8,}).*/;
    //Alpha Numeric plus minimum 8
    var good = /^(?=\S*?[a-z])(?=\S*?[0-9])\S{8,}$/;
    //Must contain at least one upper case letter, one lower case letter and (one number OR one special char).
    var better = /^(?=\S*?[A-Z])(?=\S*?[a-z])((?=\S*?[0-9])|(?=\S*?[^\w\*]))\S{8,}$/;
    //Must contain at least one upper case letter, one lower case letter and (one number AND one special char).
    var best = /^(?=\S*?[A-Z])(?=\S*?[a-z])(?=\S*?[0-9])(?=\S*?[^\w\*])\S{8,}$/;

    $('#password').on('keyup', function () {
        var password = $(this);
        var pass = password.val();
        var passLabel = $('[for="password"]');
        var stength = 'Weak';
        var pclass = 'danger';
        if (best.test(pass) == true) {
            stength = 'Very Strong';
            pclass = 'success';
        } else if (better.test(pass) == true) {
            stength = 'Strong';
            pclass = 'warning';
        } else if (good.test(pass) == true) {
            stength = 'Almost Strong';
            pclass = 'warning';
        } else if (bad.test(pass) == true) {
            stength = 'Weak';
        } else {
            stength = 'Very Weak';
        }

        var popover = password.attr('data-content', stength).data('bs.popover');
        popover.setContent();
        popover.$tip.addClass(popover.options.placement).removeClass('danger success info warning primary').addClass(pclass);

    });

    $('input[data-toggle="popover"]').popover({
        placement: 'top',
        trigger: 'focus'
    });

});
