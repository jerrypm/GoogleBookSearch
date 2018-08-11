//
//  NetworkService.swift
//  RestApAndPassingData
//
//  Created by Jerry on 16/04/18.
//  Copyright © 2018 Jerry. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class NetworkService<ResponseData: BaseEntity> {
    class func process(client: NetworkClient, onSuccess: @escaping (_ data: ResponseData) -> Void, onFailure: (() -> Void)?) {
        print("Data route: ", client.route)
        print("Data method: ", client.method)
        print("Data parameters: ", client.parameters)
        print("Data headers: ", client.headers)
//        print("Data endcoding: ", client.endcoding)

        Alamofire.request(client.route, method: client.method, parameters: client.parameters, encoding: client.endcoding, headers: client.headers)
            .responseJSON { response in
                switch response.result {
                case let .success(value):
                    onSuccess(ResponseData(json: JSON(value)))
                case .failure:
                    onFailure?()
                    NotificationBarView.show(title: "Warning!", message: "Internal Server Error", style: .danger)
                }
            }
    }
}
