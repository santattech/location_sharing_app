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

    var popup = new ol.Overlay({
      positioning: 'center-center',
      element: document.getElementById('marker')
    });
    popup.setPosition(kolkata);
    

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

    map.addOverlay(popup);
    this.map = map;
  },

  addClickEvent: function() {
    this.map.on('click', function(evt) {
      var coordinate = evt.coordinate;
      var hdms = ol.coordinate.toStringHDMS(ol.proj.transform(
          coordinate, 'EPSG:3857', 'EPSG:4326'));
      console.log(coordinate);
      console.log(hdms);
    })
  }

}
