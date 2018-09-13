//
//  NetworkManager.swift
//  19900926-Vishnupriya-NYCSchools
//
//  Created by V on 9/12/18.
//  Copyright © 2018 V. All rights reserved.
//

import UIKit

class RequestManager {
    
    let baseUrl = "https://data.cityofnewyork.us/resource/"

    enum URLS:String {
        case school = "97mf-9njv.json"
        case detail = "734v-jeq5.json"
    }
    
    func request(type:URLS) -> URLRequest? {
        if let url = URL.init(string: baseUrl + type.rawValue)  {
            return URLRequest.init(url: url)
        }
       return nil
    }
}

typealias CompletionHandler = (_ success:Bool, _ data:[[String: String]]?) -> Void

typealias DetailCompletionHandler = (_ success:Bool, _ data:SchoolDetails?) -> Void

class NetworkManager {

    func getSchools(completion: @escaping CompletionHandler) {
        
        if let request = RequestManager().request(type: .school) {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(false, nil)
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                   print(json)
                    
                } catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                
                guard let school = try? JSONDecoder().decode(SchoolList.self, from: data) else {
                    completion(false, nil)
                    return
                }
                completion(true,school)
            }
            task.resume()
        }
        else {
            completion(false, nil)
        }
    }
    
    func getSchoolDetails(completion: @escaping DetailCompletionHandler) {
        
        if let request = RequestManager().request(type: .detail) {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(false, nil)
                    return
                }
                guard let schoolDetails = try? JSONDecoder().decode(SchoolDetails.self, from: data) else {
                    completion(false, nil)
                    return
                }
                completion(true,schoolDetails)
            }
            task.resume()
        }
        else {
            completion(false, nil)
        }
    }
}
