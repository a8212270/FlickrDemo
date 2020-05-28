//
//  ServerCallAPI.swift
//  ARTouch
//
//  Created by Pony on 2019/11/12.
//  Copyright © 2019 Pony. All rights reserved.
//

import Foundation
import Alamofire


class ServerAuthCallAPI: NSObject {
    static let shared = ServerAuthCallAPI()
    struct StatusError {
        let jsonEncode = APIStatus(stat: ServerAPI_Code.IOS001.rawValue, code: nil, message: "JSON Encoder Faild")
        let jsonDecode = APIStatus(stat: ServerAPI_Code.IOS002.rawValue, code: nil, message: "JSON Decoder Faild")
    }
    let statusError = StatusError()
    
    private func callAPITask(_ ApiName: String, parameters jsonDic: [String: AnyHashable], complete: @escaping (Dictionary<AnyHashable, Any>) -> Void) {
        AF.request("\(apiUrl)&method=\(ApiName)", method: .post, parameters: jsonDic)
            .responseJSON { (response) in
                switch response.result {
                case .success:
                    if let result = response.value {
                        complete(result as! Dictionary<AnyHashable, Any>)
                    }
                    break
                case let .failure(error):
                    print(error.localizedDescription)
                }
                
        }
    }
}

extension ServerAuthCallAPI {
    private func isResSuccess(_ result: [AnyHashable: Any]) -> Bool {
        guard let resultCode = result["Error"] as? String, resultCode != "" else {
            return true
        }
        return false
    }
    
    func getAPIResponse(apiURL: APIURL, jsonType: Encodable, complete: ((_ isSuccess: Bool, _ jsonResult: Encodable)->())? = nil){
        guard let encodeJson = jsonType.encodeDic else {
            complete?(false, statusError.jsonEncode)
            return
        }
        callAPITask(apiURL.rawValue, parameters: encodeJson) { (result) in
            guard self.isResSuccess(result) else{
                complete?(false, APIStatus.decode(dic: result))
                return
            }
            guard let jsonResult = self.APIJsonDecode(apiURL, result: result) else {
                complete?(false, self.statusError.jsonDecode)
                return
            }
            complete?(true, jsonResult)
        }
    }
    
    private func APIJsonDecode(_ type: APIURL, result: [AnyHashable : Any]) -> Encodable?{
        switch type{
            /// resultCode, rCodeMsg
        case .searchPhoto:
            return searchPhotoType.Response.decode(dic: result)
        }
    }
}



