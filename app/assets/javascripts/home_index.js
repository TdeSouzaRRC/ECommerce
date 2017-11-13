/*$(function(){
    $(".category_nav").click(function(event){
        event.preventDefault();

        $(".category_nav").parent().removeClass("active");

        $(this).parent().addClass("active");
        
        var category_id = $(this).attr("data-id");
        var url = "http://localhost:3000/products/by_category/" + category_id;

        var jqxhr = $.get( url, function(data) {
            if(data.length === 0)
            {
                $(".products_container").html("");
            }
            else
            {

            }
          })
            .done(function() {

            })
            .fail(function() {
              alert( "error" );
            })
            .always(function() {

            });
    })
});*/