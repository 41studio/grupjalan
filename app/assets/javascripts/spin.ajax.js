$(document).ready(function(){
  var opts = {
    lines: 13,
    length: 0,
    width: 11,
    radius: 25,
    scale: 1.25,
    corners: 1,
    color: '#4078c0',
    opacity: 0,
    rotate: 0,
    direction: 1,
    speed: 2.2,
    trail: 57,
    fps: 20,
    zIndex: 2e9,
    className: 'spinner',
    top: '50%',
    left: '50%',
    shadow: false,
    hwaccel: false,
    position: 'fixed'
  }

  var target = document.getElementById('spinner');
  var spinner = new Spinner(opts).spin(target);

  var spin = $('#spinner');
  $(document).on('ajaxStart', function(){ spin.show() });
  $(document).on('ajaxStop', function(){ spin.hide() });
});