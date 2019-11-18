//
//  ViewController.swift
//  1
//
//  Created by D7703_22 on 2019. 11. 18..
//  Copyright © 2019년 ParkSunjae. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate{
    
    @IBOutlet weak var mytableview: UITableView!
        var locationManger = CLLocationManager()
      var content2 = NSArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib..
        mytableview.delegate = self
        mytableview.dataSource = self
        locationManger.delegate = self
        
        // 위치 트래킹 시작
        locationManger.startUpdatingHeading()
        locationManger.requestAlwaysAuthorization()
        
        //현재 위치 표시
        
         self.title = " 동의과학대학교 아이폰 중간고사"
        // 데이터 로드
        let path = Bundle.main.path(forResource: "myaddress", ofType: "plist")
         content2 = NSArray(contentsOfFile: path!)!
        

        }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = mytableview.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let myTitle = (content2[indexPath.row] as AnyObject).value(forKey: "title")
        let myAddress = (content2[indexPath.row] as AnyObject).value(forKey: "address")
        print(myAddress!)
        
        myCell.textLabel?.text = myTitle as? String
        myCell.detailTextLabel?.text = myAddress as? String
        
        return myCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoMap" {
            
            let MapMVC = segue.destination as! MapviewController
            let selectedPath = mytableview.indexPathForSelectedRow
            
            let myIndexedTitle = (content2[(selectedPath?.row)!] as AnyObject).value(forKey: "title")
            let myIndexedAddress = (content2[(selectedPath?.row)!] as AnyObject).value(forKey: "address")
            
            print("myIndexedTitle = \(String(describing: myIndexedTitle))")
            
            MapMVC.dTitle = myIndexedTitle as? String
            MapMVC.dAddress = myIndexedAddress as? String
            
        } else if segue.identifier == "GoAll" {
            
            let AllMVC = segue.destination as! AllMapController
            AllMVC.Contentss = content2
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations[0]
        let cLat = userLocation.coordinate.latitude
        let cLong = userLocation.coordinate.longitude
        
        let center = CLLocationCoordinate2D(latitude: cLat, longitude: cLong)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center, span: span)
       
    }
    
}
