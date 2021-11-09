//
//  BaseRequest.swift
//  WeatherAPITest
//
//  Created by Daniella Stefani on 08/11/21.
//

import Foundation

class BaseRequest: NSObject {

    static func GET(
        url: String,
        completionHandler: @escaping (Any) -> Void
    ) {
        guard let safeUrl = URL(string: url) else { return }
        
        var request = URLRequest(url: safeUrl, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        
        // init session
        let session = URLSession.shared

        // init datatask dengan
        let dataTask = session.dataTask(with: request) { (data, response, error) -> Void in
            if let error = error {
                print(error as Any)
            } else if let dataFromAPI = data {
                completionHandler(dataFromAPI)
            }
        }
        
        dataTask.resume()
    }
    
    static func GET(url: String,
                    header: [String: String],
                    showLoader: Bool,
                    completionHandler: @escaping (Any) -> Void) {
        if showLoader {
            // display loader
        }
        // init request
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        // configure request method dan set header
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = header

        // init session
        let session = URLSession.shared

        // init datatask dengan
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                if let dataFromAPI = data {
                    completionHandler(dataFromAPI)
                }
            }
        })

        dataTask.resume()
    }
}
