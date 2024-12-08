//  Networking.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 08/12/2024.

import Foundation
import Combine

enum API {
     
     case TRANSACTIONS
     
     var path: URL? {
         
         var component: String = ""
         
         switch(self){
             
         case .TRANSACTIONS:
               component = "transactions.json"
               break
         }
         
         //Appending Components
         guard var url = URL(string: baseURL) else {return nil}
         url.appendPathComponent(component)
         return url
         
     }
     
     var baseURL: String {
         "https://designcode.io/data/"
     }
     
}

class Networking {
      
      static var networking: Networking = Networking()
      
      func callApi<T: Decodable>(_ api: API, _ type: T.Type) -> AnyPublisher<T,   Error>? {
          
          guard let url = api.path else {
                return nil
          }
          
          return URLSession.shared.dataTaskPublisher(for: url)
              .tryMap { (data, response) -> Data in
                  guard let httpResponse = response as? HTTPURLResponse,   httpResponse.statusCode == 200 else {
                      throw URLError(.badServerResponse)
                  }
                  return data
              }
              .decode(type: T.self, decoder: JSONDecoder())
              .receive(on: DispatchQueue.main)
              .eraseToAnyPublisher()
          
      }
    
}
