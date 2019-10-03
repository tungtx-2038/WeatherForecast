//
//  ListWeatherModel.swift
//  WeatherForcast
//
//  Created by Tung Tran on 10/3/19.
//  Copyright © 2019 Sun. All rights reserved.
//

import Foundation

class ListWeatherModel: CoreObject {
    
    var coordDt: CoordModel?
    var mainDt: MainTempModel?
    var weatherDt = [WeatherModel]()
    var cloudsDt: CloudModel?
    var windDt: WindModel?
    var sysDt: SysModel?
    
    required init(data: [AnyHashable : Any]?) {
        
        if let d = data?["coord"] as? [String: Any] {
            coordDt = CoordModel(data: d)
        }
        if let d = data?["main"] as? [String: Any] {
            mainDt = MainTempModel(data: d)
        }
        if let d = data?["weather"] as? [[String: Any]] {
            weatherDt = d.map({WeatherModel(data: $0)})
        }
        if let d = data?["clouds"] as? [String: Any] {
            cloudsDt = CloudModel(data: d)
        }
        if let d = data?["wind"] as? [String: Any] {
            windDt = WindModel(data: d)
        }
        if let d = data?["sys"] as? [String: Any] {
            sysDt = SysModel(data: d)
        }
    }
}


