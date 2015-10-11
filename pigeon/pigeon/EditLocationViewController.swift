//
//  EditLocationViewController.swift
//  pigeon
//
//  Created by Liu, Naitian on 8/30/15.
//  Copyright (c) 2015 naitianliu. All rights reserved.
//

import UIKit
import MapKit

protocol EditLocationViewControllerDelegate {
    func finishEditLocation(mapItem:MKMapItem)
}

class EditLocationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var addressSearchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    
    var searchResult:NSMutableArray! = NSMutableArray()
    var locationManager:CLLocationManager!
    var userLocation:CLLocationCoordinate2D!
    var addressMapItem:MKMapItem!
    
    var delegate:EditLocationViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.searchDisplayController?.searchResultsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "ResultCell")
        self.edgesForExtendedLayout = UIRectEdge.None
        self.locationManager = CLLocationManager()
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
        
        if (CLLocationManager.locationServicesEnabled()) {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.startUpdatingLocation()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.delegate?.finishEditLocation(self.addressMapItem)
        })
    }
    
    @IBAction func cancelButtonOnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.searchResult.removeAllObjects()
        let request:MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchString
        let localSearch:MKLocalSearch = MKLocalSearch(request: request)
        localSearch.startWithCompletionHandler { (response, error) -> Void in
            var places:NSArray = NSArray()
            if response != nil {
                places = response!.mapItems
            }
            for place in places {
                let mapItem:MKMapItem = place as! MKMapItem
                self.searchResult.addObject(mapItem)
            }
            self.searchDisplayController?.searchResultsTableView.reloadData()
        }
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchResult.count == 0 {
            return 0
        } else {
            return self.searchResult.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if self.searchResult.count == 0 {
            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "NoResultCell")
            return cell
        } else {
            let cell:UITableViewCell = (self.searchDisplayController?.searchResultsTableView.dequeueReusableCellWithIdentifier("ResultCell")!)!
            cell.textLabel!.text = (self.searchResult.objectAtIndex(indexPath.row) as! MKMapItem).placemark.title
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.searchDisplayController?.setActive(false, animated: true)
        let selectMapItem = self.searchResult.objectAtIndex(indexPath.row) as! MKMapItem
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        self.mapView.centerCoordinate = selectMapItem.placemark.coordinate
        let testLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(selectMapItem.placemark.coordinate.latitude, selectMapItem.placemark.coordinate.longitude)
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(testLocation, theSpan)
        self.mapView.setRegion(theRegion, animated: true)
        self.mapView.addAnnotation(self.customizeAnnotation(testLocation, theTitle: selectMapItem.placemark.title!, theSubtitle: "目标地点"))
        self.addressMapItem = selectMapItem
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = manager.location!.coordinate
        self.locationManager.stopUpdatingLocation()
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        let theSpan: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let testLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.userLocation.latitude, self.userLocation.longitude)
        let theRegion: MKCoordinateRegion = MKCoordinateRegionMake(testLocation, theSpan)
        self.mapView.setRegion(theRegion, animated: true)
        self.mapView.addAnnotation(self.customizeAnnotation(testLocation, theTitle: "当前地点", theSubtitle: ""))
        self.addressMapItem = MKMapItem.mapItemForCurrentLocation()
    }
    
    func customizeAnnotation(theLocation:CLLocationCoordinate2D, theTitle:NSString, theSubtitle:NSString) -> MKPointAnnotation{
        let testAnnotation = MKPointAnnotation()
        testAnnotation.coordinate = theLocation
        testAnnotation.title = theTitle as String
        testAnnotation.subtitle = theSubtitle as String
        return testAnnotation
    }

}
