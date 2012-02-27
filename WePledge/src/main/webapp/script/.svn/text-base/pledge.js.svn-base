$(document).ready(function() {

    $("#pledge-submit").click(function(e) {
        e.preventDefault();

        // basic checks
        var email = $("#pledge_email").val();
        if (!email || email=="") {
            alert ("Email blank");
            return;
        }
        var name = $("#pledge_full_name").val();
        if (!name || name=="") {
            alert ("Name blank");
            return;
        }

        var amount =  parseFloat($("#pledge_amount").val());
        if (!amount || amount<=0) {
            alert ("Invalid amount entered.");
            return;
        }

        var time = new Date().getTime();
        $("#pledge_time").val(time);
        $('#pledge-submit, #settings').hide();
        $('#loader').show();

        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var latlng = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);

                var apiStruct = {
                    "campaign_id": $("#pledge_campaign_id").val(),
                    "fullname": name,
                    "email" : email,
                    "lat" : position.coords.latitude,
                    "lng" : position.coords.longitude,
                    "amount": amount,
                    "time": time
                };

                $.ajax({
                    type: "POST",
                    url: "/pledge",

                    data: $.toJSON(apiStruct),
                    contentType: 'application/json',
                    dataType: 'jsonp',

                    success: function() {
//                        $("#new_pledge").submit();

                        $("#pledge_amount").val("");
                        $("#pledge_email").val("");
                        $("#pledge_full_name").val("");

                        $('#pledge-submit, #settings').show();

                        $('#loader').hide();
                        alert('Thank for your pledge.');
                    },
                    error: function() {
                        alert("Error sending pledge.");
//                        $("#new_pledge").submit();

                        $("#pledge_amount").val("");
                        $("#pledge_email").val("");
                        $("#pledge_full_name").val("");

                        $('#pledge-submit, #settings').show();

                        $('#loader').hide();
                    }
                });
            });

            e.preventDefault();
        } // if geolocation
    });
});