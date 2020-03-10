//
//  Service.swift
//  CountryFlagApp
//
//  Created by Ümit on 5.03.2020.
//  Copyright © 2020 Example. All rights reserved.
//

import Foundation

public class Service {
    
    static func getCountryDetails(completion: @escaping ((_ result: [[String: Any]]?, _ error: String? ) -> ())) {
        
        guard let url = URL(string: "https://restcountries.eu/rest/v2/all") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completion(nil, error?.localizedDescription)
            }
            else if data != nil {
                do {
                    let jsonResponse = try JSONSerialization.jsonObject(with:data!, options: [])
                    guard let jsonArray = jsonResponse as? [[String: Any]] else { return }
                    completion(jsonArray, nil)
                    
                }
                catch {
                    print("json processing failed")
                    completion(nil, error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
