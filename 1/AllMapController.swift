//
//  AllMapController.swift
//  1
//
//  Created by D7703_22 on 2019. 11. 18..
//  Copyright © 2019년 ParkSunjae. All rights reserved.
//

import UIKit
import MapKit

class AllMapController: UIViewController {
    
    var Contentss: NSArray?
    
    @IBOutlet weak var AllMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("Contentss = \(String(describing: Contentss))")
        
        var Pin = [MKPointAnnotation]()
        
        if let myItems = Contentss {
            for item in myItems {
                let address = (item as AnyObject).value(forKey: "address")
                let title = (item as AnyObject).value(forKey: "title")
                let geoCoder = CLGeocoder()
                
                geoCoder.geocodeAddressString(address as! String, completionHandler: { placemarks, error in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let myPlacemarks = placemarks {
                        let myPlacemark = myPlacemarks[0]
                        
                        let Pins = MKPointAnnotation()
                        Pins.title = title as? String
                        Pins.subtitle = address as? String
                        
                        if let myLocation = myPlacemark.location {
                            Pins.coordinate = myLocation.coordinate
                            Pin.append(Pins)
                        }
                        
                    }
                    
                    self.AllMapView.showAnnotations(Pin, animated: true)
                    self.AllMapView.addAnnotations(Pin)
                } )
            }
            
        } else {
            print("dContents의 값은 nil")
        }
        
    }
}
