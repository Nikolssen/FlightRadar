//
//  MockNetworkService.swift
//  FlightRadarTests
//
//  Created by Ivan Budovich on 11/16/21.
//

import Foundation
@testable import FlightRadar
import RxSwift

class MockNetworkService: NetworkService {
    
    var sourceJSON: Data?
    var didPerformRequest: Bool = false
    func request<ResponseModel>(request: APIRequest) -> Observable<ResponseModel> where ResponseModel : Decodable {
        guard let sourceJSON = sourceJSON, let model = try? JSONDecoder().decode(ResponseModel.self, from: sourceJSON) else {
            return Observable.error(NSError(domain: "Error", code: 404, userInfo: [:]))
        }
        return Observable.just(model)
    }
}
