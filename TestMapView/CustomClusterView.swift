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
    private var label: UILabel!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // Basic setup
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
        
        // Initialize the label
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black // Customize as needed
        label.font = UIFont.systemFont(ofSize: 12) // Customize as needed
        label.layer.cornerRadius = 5 // Adjust as needed for rounded corners
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 0, height: 0)
        label.layer.masksToBounds = false
        label.clipsToBounds = true


        addSubview(label)
        
        // Constraints to position the label below the image
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: bottomAnchor, constant: 5), // Adjust the constant to position the label correctly
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: 100) // Adjust as needed
        ])
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        
        // Customize the appearance
        if let cluster = annotation as? MKClusterAnnotation {
            if let pinImage = UIImage(named: "mapPinRed") {
                let scaledSize = CGSize(width: pinImage.size.width / 4, height: pinImage.size.height / 4)
                let scaledImage = pinImage.resized(to: scaledSize)
                image = scaledImage
            }
            
            // Update the label with the number of items in the cluster
            label.text = "\(cluster.memberAnnotations.count) annotations"
        }
    }
}

