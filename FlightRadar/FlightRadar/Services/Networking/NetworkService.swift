//
//  NetworkService.swift
//  FlightRadar
//
//  Created by Ivan Budovich on 10/29/21.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

protocol NetworkService {
    
}

final class APIService: NetworkService {
    func request<ResponseModel: Decodable>(request: APIRequest) -> Observable<ResponseModel> {
        AF.request(request.path, method: .get, parameters: request.parameters, encoding: URLEncoding.queryString, headers: request.headers)
            .cURLDescription{ print($0)}
            .rx.decodable(decoder: JSONDecoder())
                
    }
}
