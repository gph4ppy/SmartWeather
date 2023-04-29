//
//  LocationService.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func didSetLocation()
}

protocol LocationServiceProtocol {
    var manager: SWLocationManager { get }
    var delegate: LocationServiceDelegate? { get set }
    var city: String? { get }
}

final class LocationService: NSObject, LocationServiceProtocol {
    let manager: SWLocationManager
    var city: String?
    weak var delegate: LocationServiceDelegate?

    init(manager: SWLocationManager = SWLocationManager()) {
        self.manager = manager
        super.init()
        manager.delegate = self
    }
}
