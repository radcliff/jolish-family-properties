init = ->

  resize = () ->
    $map = $('#map')
    $map.height $(window).height()
    map.invalidateSize() if map

  resize()

  $(window).on 'resize', () ->
    resize()

  southWest = L.latLng 37.7001595937, -122.3545643238
  northEast = L.latLng 37.8114092165, -122.5191084083
  bounds = L.latLngBounds southWest, northEast

  map = L.map 'map',
    center: [37.7690, -122.4351]
    zoom: 13
    minZoom: 13
    maxBounds: bounds


  baseLayer = L.tileLayer 'https://arcane-earth-7958.herokuapp.com/v2/sf-tiles/{z}/{x}/{y}.png'
  baseLayer.addTo map

  ownerColors = 
    'Jolish Limited Partnership': 'coral'
    'Emanuel & Ahuva Jolish': ' crimson'
    'Barak & Taly Jolish': 'gold'
    'Oded Schwartz & Ruth Rosenthal': 'steelblue'
    'Rony Rolnizky & Lulu Carpenter': 'green'
    'Isaac Michael Safier': 'peachpuff'
    'Zepporah Glass Trust': 'mediumorchid'
    'Glass Properties LP': 'violet'
    '2917-2919 24th Street Partners LLC': 'goldenrod'

  addMarker = (property) ->
    options =
      weight: 1
      radius: 7.5
      fillOpacity: 1.0

    options.data = property.owners
    options.chartOptions = {}

    for owner of property.owners
      color = ownerColors[owner]

      pieSlice = {}
      pieSlice[owner] =
        fillColor: color
        displayText: (value) ->
          [value, '%'].join('') 
      $.extend options.chartOptions, pieSlice

    marker = new L.PieChartMarker(property.location, options)
    map.addLayer marker

  for property in properties
    addMarker(property)

window.onLoad = init()
