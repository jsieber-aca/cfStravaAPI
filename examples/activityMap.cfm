<cfoutput>
<html>
    <head>
        <title>cfStravaAPI - Current Athlete Activities</title>
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&libraries=geometry"></script>
    </head>
    <body>
        <a href="/index.cfm">Return to examples...</a>

        <cfset data = application.strava.getActivityMap(session.token, 209459131) />

        <div id="map-canvas" style="width: 800px; height: 500px;"></div>

        <script>
            function initialize() {
                var mapOptions = {
                    zoom: 3,
                    center: new google.maps.LatLng(0, -180),
                    mapTypeId: google.maps.MapTypeId.TERRAIN
                  };

                var map = new google.maps.Map(document.getElementById('map-canvas'),
                  mapOptions);

                var decodedPolyline = google.maps.geometry.encoding.decodePath('#replace(data.map.polyline, "\", "\\","all")#');
                // alert(decodedPolyline);
                var track = new google.maps.Polyline({
                    path: decodedPolyline,
                    geodesic: true,
                    strokeColor: '##FF0000',
                    strokeOpacity: 1.0,
                    strokeWeight: 2
                });

                track.setMap(map);

                //Set bounds based on polyline
                var bounds = new google.maps.LatLngBounds();
                for (var i = 0; i < decodedPolyline.length; i++) {
                    bounds.extend(decodedPolyline[i]);
                }
                // zoom and center map around bounds
                map.fitBounds(bounds);
            }

            google.maps.event.addDomListener(window, 'load', initialize);


        </script>
    </body>
</html>
</cfoutput>
