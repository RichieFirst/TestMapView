//
//  CustomClusterView.swift
//  TestMapView
//
//  Created by Richard Svoboda on 25.03.2024.
//

import Foundation
import MapKit


class CustomClusterView: MKAnnotationView {
    static let reuseID = "CustomClusterAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        // Basic setup
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        // Customize the appearance based on your conditions here
        // For example, if the cluster contains more than 10 annotations, use a special image
        if let pinImage = UIImage(named: "mapPinRed") { // Replace "mapPinRed" with the name of your custom image asset
            // Resize the image to half of its original size
            let scaledSize = CGSize(width: pinImage.size.width / 4, height: pinImage.size.height / 4)
            let scaledImage = pinImage.resized(to: scaledSize)
            
            // Set the custom image and hide the pin
            image = scaledImage
        }
    }
}
