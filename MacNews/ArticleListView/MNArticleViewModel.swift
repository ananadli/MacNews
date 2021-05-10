//
//  MNArticleViewModel.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import Foundation
import Combine

class MNArticleViewModel: ObservableObject {

    
   
    @Published var articles = [MNArticleModel]()
    @Published var isLoading : Bool = false
        var cancellables = Set<AnyCancellable>()
    @Published var error : Error?
    @Published var isError : Bool = false
    init() {
        self.fetchAllArticles()

    }
    func fetchAllArticles(){
        isLoading = true
        let cancellable = MNMacNewsAPI.fetchAllArrticalsService()
      
            
        
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    DispatchQueue.main.async {

                    self.error =  error
                        self.isError = true
                    }
                case .finished:
                    break
                }
                DispatchQueue.main.async {

                self.isLoading = false

                }
            }) { (articalRespons) in
                DispatchQueue.main.async {
                    
                
                self.articles = articalRespons.articles
                }
        }
        cancellables.insert(cancellable)
    }
    
    
   
}



