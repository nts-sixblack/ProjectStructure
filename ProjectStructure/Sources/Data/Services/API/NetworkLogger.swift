//
//  NetworkLogger.swift
//  ProjectStructure
//
//  Created by Thanh Sau on 12/12/24.
//

import Foundation
import Alamofire

import Alamofire

class GitNetworkLogger: EventMonitor {
    
    let queue = DispatchQueue(label: "com.sixblack.network.logger")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request<Value>(
        _ request: DataRequest,
        didParseResponse response: DataResponse<Value, AFError>
    ) {
//        guard let data = response.data else {
//            return
//        }
//        if let json = try? JSONSerialization
//            .jsonObject(with: data, options: .mutableContainers) {
//            print(json)
//        }
    }
}

