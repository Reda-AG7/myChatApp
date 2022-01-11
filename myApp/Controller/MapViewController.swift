//
//  MapViewController.swift
//  myApp
//
//  Created by Reda Agourram on 1/8/22.
//

import UIKit
import MapKit
import CoreLocation


protocol myMapDataDelegate{
    func myMapdelegate(region:MKCoordinateRegion)
}

class MapViewController: UIViewController,CLLocationManagerDelegate {
    var myRegion:MKCoordinateRegion?
    let defaultRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    var myMapdelegate: myMapDataDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            setLocation(location: location)
            //addPin(location: location)
            print("location ::::: \(location)")
        }
    }
    func setLocation(location: CLLocation){
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        myRegion = region
        map.setRegion(region, animated: true)
        addPin(location: location)
    }
    @IBAction func sendPressed(_ sender: UIButton) {
        myMapdelegate.myMapdelegate(region: myRegion ?? defaultRegion)
        navigationController?.popViewController(animated: true)
    }
    func addPin(location: CLLocation){
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        pin.title = "My location"
        map.addAnnotation(pin)
    }
}
