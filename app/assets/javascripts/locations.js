var LS = LS || {};

LS.Map = {
  initMap: function () {
    var kolkata = ol.proj.fromLonLat([88.3639, 22.5726]);
    var view = new ol.View({
      center: kolkata,
      zoom: 8
    });

    var layers = [
      new ol.layer.Tile({
        source: new ol.source.OSM()
      })
    ];

    var map = new ol.Map({
      layers: layers,
      target: 'map',
      controls: ol.control.defaults({
        attributionOptions: {
          collapsible: false
        }
      }),
      view: view
    });

    var locations = $("#map").data("locations");
    $.each(locations, function(index, location){
      var coord = ol.proj.transform([location.latitude, location.longitude], 'EPSG:3857', 'EPSG:4326' );
      var pos = ol.proj.fromLonLat(coord);
      var i = index + 1;

      var popup = new ol.Overlay({
        positioning: 'center-center',
        position: pos,
        element: document.getElementById('marker-'+i)
      });
  
      map.addOverlay(popup);

      var locationText = new ol.Overlay({
        element: document.getElementById('loc-' + i),
        position: pos
      });

      map.addOverlay(locationText);
    });

    /*var popup = new ol.Overlay({
      positioning: 'center-center',
      element: document.getElementById('marker')
    });
    popup.setPosition(kolkata);
    

    

    //map.addOverlay(popup);*/
    this.map = map;
  },

  addClickEvent: function() {
    this.map.on('click', function(evt) {
      var coordinate = evt.coordinate;
      var hdms = ol.coordinate.toStringHDMS(ol.proj.transform(
          coordinate, 'EPSG:3857', 'EPSG:4326'));
      console.log(coordinate);
      var userId = $("#map").data("user");

      if(confirm("Are you sure, you want to add/checkin to this location?")) {
        $.post("/users/"+ userId +"/locations", { latitude: coordinate[0], longitude: coordinate[1] }).
          done(function(response) {
            window.location.href = "/users/"+ userId +"/locations";
          })
      }
    })
  }

}
