//= require jquery

$(document).ready(function(){
    if($('.increase_quantity').length > 0){
        increase_decrease_quantity();
    }
    if($('.rating_form').length > 0){
        number = $('#rating_field').val();
        set_rating(number);
        var stars = [
            $('#star1'),
            $('#star2'),
            $('#star3'),
            $('#star4'),
            $('#star5')
        ]
        $.each(stars, function (index, field) {
            field.on('click', function () {
                number = field.attr("id").replace(/\D/g,'');
                set_rating(number);
            });
        });
    }

    function  set_rating(number) {
        $('#rating_field').val(number);
        var n;
        for (n = 1; n <= number; ++ n) {
            star_id = "#star"+n;
            rate_star = $(star_id);
            rate_star.addClass('checked');
        }
        for (; n <= 5; ++ n) {
            star_id = "#star"+n;
            rate_star = $(star_id);
            rate_star.removeClass('checked');
        }
    }
    function increase_decrease_quantity() {
        plus = $('.plus');
        minus = $('.minus');

        plus.on('click', function () {
            value = $('.quantity').val()
            value = parseInt(value)+1;
            $('.quantity').val(value)
            if(value >= 1) {
                minus.removeClass('disabled');
                minus.addClass('btn-secondary');
            }
        });
        minus.on('click', function () {
            value = $('.quantity').val()
            value = parseInt(value);
            if(value <= 1){
                minus.addClass('disabled');
                minus.removeClass('btn-secondary');
            }else{
                value = parseInt(value)-1;
                $('.quantity').val(value)
            }

        });
    }
});
