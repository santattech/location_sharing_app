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
    
  }
}
