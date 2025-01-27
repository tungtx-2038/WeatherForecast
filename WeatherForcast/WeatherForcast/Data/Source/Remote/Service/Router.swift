//
//  Router.swift
//  WeatherForcast
//
//  Created by Tung Tran on 10/1/19.
//  Copyright © 2019 Sun. All rights reserved.
//

import Foundation
import Alamofire

class Router {
    
    static var baseUrl = "api.openweathermap.org"
    
    func buildUrlRequest(_ route: Route) -> URLRequestConvertible {
        return RouterUrlConvertible(route: route)
    }
    
    func buildValidFullPathForRequest(_ path: PathURL) -> String {
        guard let url = URL(string: Router.baseUrl) else {
            return path.rawValue
        }
        return url.appendingPathComponent(path.rawValue).absoluteString
    }
    
    
    //
    enum PathURL: String {
        case currentWeather = "/data/2.5/weather?" //param: key, city name (q), city id ( id )
        case fiveDaysThreeHours = "/data/2.5/forecast?" // param: city name (q), city id (id)
        case uvIndex = "/data/2.5/uvi?"// param: lat , long
        case airPolution = "/pollution/v1/co/" //param: lat, long
    }
}
