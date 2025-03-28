//
//  File.swift
//  Theskinny
//
//  Created by Ben Schultz on 2025-01-08.
//

import Foundation
import Plot
import Publish

struct BigTripMap: Component {
    
    let kmz: String
    let text: String
    
    init() {
        kmz = EnvironmentKey.bigtripMapKMZ
        text = "Coordinates start a little after Solvenia, due to time it took to bring our instrument that posted data to the mothership up and online."
    }
    
    init(kmz: String, text: String) {
        self.kmz = kmz
        self.text = text
    }
    
    
    var body: Component {
        Div {
            Div().id("map").style("height: 800px;")
            script
        }
    }
    
    let scriptInit: Node<HTML.HeadContext> = {
        var attribute = Attribute<Script>.attribute(named: "async", value: nil)
        attribute.ignoreIfValueIsEmpty = false
        return Script("")
            .attribute(attribute)
            .attribute(named: "src", value: "https://maps.googleapis.com/maps/api/js?key=\(EnvironmentKey.googleMapsAPIKey)&callback=initMap")
            .convertToNode()
    }()
    
    let script = Script("""
    
        var map;
        var src = '\(EnvironmentKey.bigtripMapKMZ)';

        function initMap() {
          map = new google.maps.Map(document.getElementById('map'), {
            center: new google.maps.LatLng(38.9855, 5.96789),
            zoom: 5,
            mapTypeId: 'satellite'  
          });

          var kmlLayer = new google.maps.KmlLayer(src, {
            suppressInfoWindows: true,
            preserveViewport: false,
            map: map
          });
          kmlLayer.addListener('click', function(event) {
            var content = event.featureData.infoWindowHtml;
            var testimonial = document.getElementById('capture');
            testimonial.innerHTML = content;
          });
        }
    
    """)
    
   
    
}

//&location=37.7749,-122.4194&pano=some_pano_id
