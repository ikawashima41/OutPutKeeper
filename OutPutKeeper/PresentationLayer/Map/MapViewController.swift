//
//  MapViewController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import Foundation

final class MapViewController: UIViewController {

    private let locationManager = CLLocationManager()

    var mapView = GMSMapView()

    var params: [String: Any] {
        var data = [String: Any]()
        data["origin"] = "-1223, -234549"
        data["destination"] = "3000, 234549"
        return data
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        setupMap()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

            let origin = "\(43.1561681),\(-75.8449946)"
            let destination = "\(38.8950712),\(-77.0362758)"


            let url = "https://maps.googleapis.com/maps/api/directions/json?" +
            "origin=\(origin)&destination=\(destination)&" + "key=AIzaSyBjRv2JuwcGBosistRWPE2v13EKwDY8N0g"

            AF.request(url).responseJSON { response in
                let mapResponse: [String: AnyObject] = response as! [String : AnyObject]

                let routesArray = (mapResponse["routes"] as? Array) ?? []

                let routes = (routesArray.first as? Dictionary<String, AnyObject>) ?? [:]

                let overviewPolyline = (routes["overview_polyline"] as? Dictionary<String,AnyObject>) ?? [:]
                let polypoints = (overviewPolyline["points"] as? String) ?? ""
                let line = polypoints

        }
    }

    private func setupMap() {

        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)

        view = mapView

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true

        let maker = GMSMarker()
        maker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        maker.title = "Sydney"
        maker.snippet = "Australia"
        maker.map = mapView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }

        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)

        // 8
        locationManager.stopUpdatingLocation()
    }
}
