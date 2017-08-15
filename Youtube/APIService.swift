//
//  APIService.swift
//  Youtube
//
//  Created by Harry Cao on 25/6/17.
//  Copyright © 2017 Apps Innovation. All rights reserved.
//

import Foundation

class APIService: NSObject {
  static let sharedInstance = APIService()
  
  let baseUrlString = "https://s3-us-west-2.amazonaws.com/youtubeassets"
  
  func fetchHomeVideos(completion: @escaping ([Video]) -> ()) {
    fetchVideos(with: "\(baseUrlString)/home.json", completion: completion)
  }
  
  func fetchTrendingVideos(completion: @escaping ([Video]) -> ()) {
    fetchVideos(with: "\(baseUrlString)/trending.json", completion: completion)
  }
  
  func fetchSubscriptionsVideos(completion: @escaping ([Video]) -> ()) {
    fetchVideos(with: "\(baseUrlString)/subscriptions.json", completion: completion)
  }
  
  func fetchVideos(with urlString: String, completion: @escaping ([Video]) -> ()) {
    let url = URL(string: urlString)
    URLSession.shared.dataTask(with: url!) { (data, response, error) in
      if let error = error {
        print(error)
        return
      }
      
      do {
        if let data = data,
           let jsonDictionaries = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: AnyObject]] {
          
          DispatchQueue.main.async {
            completion(jsonDictionaries.map({ Video(with: $0) }))
          }
        }
        
      } catch let jsonError {
        print(jsonError)
      }
      }.resume()
  }
}
