// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require bootstrap.min


$(document).ready(function(){
    $('#master').hide();
    $('#visa').hide();
    let pay_type = $('#credit_card');
    pay_type.on('change', function () {
        if(pay_type.val() == 'VISA'){
            $('#master').hide(500);
            $('#visa').show(500);
        }else{
            $('#visa').hide(500);
            $('#master').show(500);
        }
    })
});
