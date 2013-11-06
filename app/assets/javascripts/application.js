//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
                                                    /* FIX THIS PAGE */
    $('a.cart').click(function() {
        var cart = $('#cart');
        if(cart.is(':visible')) {
            cart.hide();
        } else {
        $.get('/cart', function(html) {
            $('#cart').html(html).show();
        });
        }
        return false;
    });
    $('.add_to_cart').click(function(){
        try {
            var action = $(this).parents('form').attr('action');
            $.ajax({
                type: "POST",
                url: action,
                dataType: 'json',
                success: function(json) {
                    $('#cart_item_count').text(json.item_count);
                }
            });
        } catch(e) {
            console.log(e);
        } finally {
            return false;
        }
    });                                   /* updates cart count */
});
