//
//  File.swift
//  WeatherForcast
//
//  Created by Tung Tran on 10/17/19.
//  Copyright © 2019 Sun. All rights reserved.
//

import Foundation
import Alamofire

typealias Failure = ((_ message: String?, _ errcode: Int?) -> Void)

final class ServiceHelper {

    private var currentService: CurrentService
    private let fiveDayService: FiveDayService
    private let placeService: PlaceService
    private let uvService: UVIndexService
    private let airService: AirPolutionService

    private init(_ currentService: CurrentService, _ fiveDayService: FiveDayService,
                 _ placeService: PlaceService, _ uvService: UVIndexService,
                 _ airService: AirPolutionService) {
        self.currentService = currentService
        self.fiveDayService = fiveDayService
        self.placeService = placeService
        self.uvService = uvService
        self.airService = airService
    }

    static func getInstance(_ currentService: CurrentService, _ fiveDayService: FiveDayService,
                            _ placeService: PlaceService, _ uvService: UVIndexService,
                            _ airService: AirPolutionService) -> ServiceHelper {
        return ServiceHelper(currentService, fiveDayService, placeService,
                             uvService, airService)
    }

    func getWeather(param: CurrentWeatherParams,
                    onSuccess: @escaping ((_ data: CurrentWeather) -> Void),
                    onFailed: @escaping Failure) {
        currentService.getCurrentWeather(param: param).cloudResponse { (response: CurrentWeatherResponse) in
            guard let data = response.object else {
                onFailed(response.statusMessage, response.statusCode)
                return
            }
            onSuccess(data)
        }.cloudError { (errMsg, errCode) in
            onFailed(errMsg, errCode)
        }
    }

    func getPlace(param: PlaceParams,
                  onSuccess: @escaping ((_ data: [Place]) -> Void),
                  onFailed: @escaping Failure) {
        placeService.getPlace(param: param).cloudResponse { (response: PlaceResponse) in
            onSuccess(response.places)
        }.cloudError { (errMsg, errCode) in
            onFailed(errMsg, errCode)
        }
    }

    func getFiveDayData(param: FiveDayParams,
                        onSuccess: @escaping ((_ data: [FiveDayWeather]) -> Void),
                        onFailed: @escaping Failure) {
        fiveDayService.getFiveDayData(param: param).cloudResponse { (response: FiveDayResponse) in
            onSuccess(response.listData)
        }.cloudError { (errMsg, errCode) in
            onFailed(errMsg, errCode)
        }
    }

    func getAirPolutionData(param: Coordinate,
                            onSuccess: @escaping ((_ data: AirPolution) -> Void),
                            onFailed: @escaping Failure) {
        airService.getAirPolutionData(param: param).cloudResponse { (response: AirPolutionResponse) in
            guard let data = response.dataList.first else {
                onFailed(response.statusMessage, response.statusCode)
                return
            }
            onSuccess(data)
        }.cloudError { (errMsg, errCode) in
            onFailed(errMsg, errCode)
        }
    }

    func getUVData(param: UVIndexParams,
                   onSuccess: @escaping ((_ data: UVIndex) -> Void),
                   onFailed: @escaping Failure) {
        uvService.getUVData(param: param).cloudResponse { (response: UVIndexResponse) in
            guard let data = response.uvIndex.first else {
                onFailed(response.statusMessage, response.statusCode)
                return
            }
            onSuccess(data)
        }.cloudError { (errMsg, errCode) in
            onFailed(errMsg, errCode)
        }
    }
}
