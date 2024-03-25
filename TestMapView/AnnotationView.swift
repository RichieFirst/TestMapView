//
//  AnnotationView.swift
//  TestMapView
//
//  Created by Richard Svoboda on 25.03.2024.
//

import Foundation
import MapKit

let clusterID = "clustering"

class AnnotationView: MKMarkerAnnotationView {
    
    static let ReuseID = "cultureAnnotation"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
        clusteringIdentifier = clusterID
        glyphText = "" // Set glyph text or use a custom image
        markerTintColor = .clear // Set marker tint color
        canShowCallout = false // Hide callout
        selectedGlyphImage = nil
        
        // Set the custom image and hide the pin
        if let pinImage = UIImage(named: "mapPinRed") { // Replace "mapPinRed" with the name of your custom image asset
            // Resize the image to half of its original size
            let scaledSize = CGSize(width: pinImage.size.width / 4, height: pinImage.size.height / 4)
            let scaledImage = pinImage.resized(to: scaledSize)
            
            // Set the custom image and hide the pin
            image = scaledImage
            glyphImage = UIImage() // Hide the pin
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        displayPriority = .defaultLow
    }
}
