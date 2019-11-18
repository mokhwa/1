//
//  MapviewController.swift
//  1
//
//  Created by D7703_22 on 2019. 11. 18..
//  Copyright © 2019년 ParkSunjae. All rights reserved.
//

import UIKit
import MapKit
class MapviewController: UIViewController {

    var dTitle: String?
    var dAddress: String?
    
    @IBOutlet weak var MapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("dTitle = \(String(describing: dTitle))")
        print("dAddress = \(String(describing: dAddress))")
        self.title = dTitle
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(dAddress!, completionHandler: { plackmarks, error in
            
            if error != nil {
                print(error!)
            }
            
            if plackmarks != nil {
                let myPlacemark  = plackmarks?[0]
                
                if (myPlacemark?.location) != nil {
                    let myLat = myPlacemark?.location?.coordinate.latitude
                    let myLong = myPlacemark?.location?.coordinate.longitude
                    let center = CLLocationCoordinate2DMake(myLat!, myLong!)
                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: center, span: span)
                    self.MapView.setRegion(region, animated: true)
                    
                    // Pin 꼽기, title, suttitle
                    let anno = MKPointAnnotation()
                    anno.title = self.dTitle
                    anno.subtitle = self.dAddress
                    anno.coordinate = (myPlacemark?.location?.coordinate)!
                    self.MapView.addAnnotation(anno)
                    self.MapView.selectAnnotation(anno, animated: true)
                }
            }
            
        } )

        // Do any additional setup after loading the view.
    }
}
