//
//  DataService.swift
//  Reuse cell
//
//  Created by AnhTT on 8/11/20.
//  Copyright © 2020 AnhTT. All rights reserved.
//

import UIKit

class DataService {
    static let sharing: DataService = DataService()
    
    func getData(completion: @escaping([HeroStats]) -> Void) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else { return }
        let urlRequest = URLRequest(url: url)
        let downloadTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            do {
                let recivedData = try JSONDecoder().decode([HeroStats].self, from: data!)
                
                DispatchQueue.main.async {
                    completion(recivedData)
                }
            } catch {
                print(error)
            }
        })
        
        downloadTask.resume()
    }
}
