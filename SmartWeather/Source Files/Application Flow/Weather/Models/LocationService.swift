//
//  LocationService.swift
//  SmartWeather
//
//  Created by Jakub Dąbrowski on 26/04/2023.
//

import CoreLocation

protocol LocationServiceProtocol {
    var manager: SWLocationManager { get }
    var city: String? { get }
    var country: String? { get }
}

final class LocationService: NSObject, LocationServiceProtocol {
    let manager: SWLocationManager
    var city: String?
    var country: String?

    init(manager: SWLocationManager = SWLocationManager()) {
        self.manager = manager
        super.init()
        manager.delegate = self

        Task {
            city = await manager.getPlaceMark().city
            country = await manager.getPlaceMark().country
        }
    }
}
