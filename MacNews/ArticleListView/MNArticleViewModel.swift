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
        
   
    func getAllArticles(){
        isLoading = true
        let cancellable = MNMacNewsAPI.getAllArticles()
      
            
        
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
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



