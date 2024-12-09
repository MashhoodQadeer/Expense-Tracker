//  ContentViewModel.swift
//  Expense Tracker
//  Created by Mashhood Qadeer on 10/12/2024.

import Combine

class ContentViewModel: ObservableObject {
       
      @Published var transactionsList: [Transaction] = []
      
      //Loader
      @Published var loading: Bool = false
    
      //DisposeBags
      var disposeBags: Set<AnyCancellable> = Set<AnyCancellable>()
      
      func loadTransactions(){
          
          //Fetching The API Response
          let api = API.TRANSACTIONS
          
          
          self.loading = true
          Networking.networking.callApi(api, [Transaction].self)?.sink(receiveCompletion: { [weak self] completion in
              
              guard let self = self else {return}
              
              self.loading = false
              switch(completion) {
                  
              case .failure( let error ):
                    break
                  
              case .finished:
                    break
                  
              }
              
          }, receiveValue: { transactionsList in
             
             self.transactionsList = transactionsList
              
          }).store(in: &self.disposeBags)
          
      }
    
}
