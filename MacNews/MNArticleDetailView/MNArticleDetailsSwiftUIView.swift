//
//  MNArticleDetailsSwiftUIView.swift
//  MacNews
//
//  Created by Anan Suliman on 06/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct MNArticleDetailsSwiftUIView: View {
    @ObservedObject var viewModel : MNArticleDetailsViewModel
    
    var body: some View {
        ZStack {
            Color("background-color").ignoresSafeArea()
            VStack(alignment: .center, spacing: nil, content: {
                
                MNArticalDetailsHeaderView(viewModel: viewModel).padding()
                ScrollView(.vertical, showsIndicators: true, content: {

                    HStack {
                        Text(viewModel.article.title).font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(.black).multilineTextAlignment(.leading).padding([.leading,.trailing,.bottom])
                        Spacer()
                    }
                
                HStack(alignment: .center, spacing: nil, content: {
                    HStack(alignment: .center, spacing: nil, content: {

                    VStack(alignment: .leading, spacing: 5, content: {
                            Text(viewModel.articleContentModelResponse?.author ?? "Author Name").foregroundColor(Color("subtitle-color")).font(.system(size: 15, weight: .semibold, design: .default))
                            Text(viewModel.article.getRelativePubDateFormat()).foregroundColor(.gray).font(.system(size: 13, weight: .medium, design: .default))
                        })
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "bookmark").foregroundColor(Color("subtitle-color")).font(.system(size: 20, weight: .semibold, design: .default))
                        })
                    })
                }).padding([.leading,.trailing])
                    
            
                WebImage(url: URL(string: viewModel.article.thumbnail)).resizable().scaledToFill().frame(height: 200, alignment: .center).background(Color(.lightGray)).clipped()
                MNArticleHTMLContentView(articleHTMLBody:viewModel.articleContentModelResponse?.hypertTextContent ?? "No Valid Content").frame( height: 20000, alignment: .center)
               })

            }).ignoresSafeArea(edges: .bottom).onAppear(perform: {
                viewModel.fetchArticleDetails()
        }).navigationBarHidden(true)
        }
    }
}

struct MNArticleDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNArticleDetailsSwiftUIView(viewModel: MNArticleDetailsViewModel(article: MNArticleModel(idPath: "/articles/1.json", title: "Windows 10 Gaining Improved Audio Support for AirPods in Future Update", pubDate: Date(), category: "AirPods", thumbnail: "https://images.macrumors.com/article-new/2020/11/windows-10.jpg")))
    }
}

struct MNArticalDetailsHeaderView: View {
    @ObservedObject var viewModel : MNArticleDetailsViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
            
        
        HStack(alignment: .center, spacing: nil, content: {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()

            }, label: {
                Image(systemName: "chevron.backward").font(.system(size: 25, weight: .bold, design: .default)).foregroundColor(Color("subtitle-color"))
            })
            Spacer()
            
           
            
            
        })
    }
}
