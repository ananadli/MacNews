//
//  MNArticleViewModel.swift
//  MacNews
//
//  Created by Anan Suliman on 06/05/2021.
//

import Foundation
import Combine

class MNArticleDetailsViewModel: ObservableObject {
    
    @Published var article : MNArticleModel
    @Published var error : Error?
    @Published var isError : Bool = false

    var cancellables = Set<AnyCancellable>()
    
    
    init(article : MNArticleModel) {
        self.article = article
        self.fetchArticleDetails()
    }
    //Fetch the full artical and **overwrite the initiated artical**
    func fetchArticleDetails() {
        
        let cancellable = MNMacNewsAPI.fetchArticleContentService(article:article)

            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    print("Handle error: \(error)")
                    DispatchQueue.main.async {
    //Set the error to published error object display alert in the view
                    self.error =  error
                    self.isError = true
                    }
                case .finished:
                    break
                }

            }) { (articalContentResponse) in
                DispatchQueue.main.async {
                    
                //** Overwrite the list article
                self.article = articalContentResponse

                }

            }
        cancellables.insert(cancellable)
    }
    
}
