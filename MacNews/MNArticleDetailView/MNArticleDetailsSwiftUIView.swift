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
    @AppStorage(UserDefaultsKeys.BookmarkedArticles.rawValue) var bookmarkList : [String] = []
    
    var body: some View {
        ZStack {
            //Changing Background Color
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
                        Text(viewModel.article.author ).foregroundColor(Color("subtitle-color" )).font(.system(size: 15, weight: .semibold, design: .default))
                            Text(viewModel.article.getRelativePubDateFormat()).foregroundColor(.gray).font(.system(size: 13, weight: .medium, design: .default))
                        })
                        Spacer()
                        Button(action: {
                            //This logic is to bookmark and un-bookmark an artical via savin the id in a @AppStorage array of strings
                            if bookmarkList.contains(viewModel.article.idPath) {
                                //Remove from bookmark list
                                if let index = bookmarkList.firstIndex(of: viewModel.article.idPath){
                                    bookmarkList.remove(at: index)
                                }
                                
                            }else{
                                //Add to bookmark list
                                bookmarkList.append(viewModel.article.idPath)

                            }
                        }, label: {
                                //the image name changes if the artical id is in the @AppStorege array
                            Image(systemName: bookmarkList.contains(viewModel.article.idPath) ? "bookmark.fill" : "bookmark").foregroundColor(Color("subtitle-color")).font(.system(size: 20, weight: .semibold, design: .default))
                            
                            
                        })
                    })
                }).padding([.leading,.trailing])
                    
            
                WebImage(url: URL(string: viewModel.article.thumbnail)).resizable().scaledToFill().frame(height: 200, alignment: .center).background(Color(.lightGray)).clipped()
                    MNArticleHTMLContentView(articleHTMLBody:viewModel.article.hypertTextContent).frame( height: 20000, alignment: .center)
               })

            }).ignoresSafeArea(edges: .bottom).navigationBarHidden(true)
            
            //This alert to display errors and the $viewModel.isError binding it must be handled by the alert (False Case)
        }.alert(isPresented: $viewModel.isError, content: {
            Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Error Accrued"), dismissButton: .default(Text("Ok")))
        })
    }
}

struct MNArticleDetailsSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNArticleDetailsSwiftUIView(viewModel: MNArticleDetailsViewModel(article: MNArticleModel(idPath: "/articles/1.json", title: "Windows 10 Gaining Improved Audio Support for AirPods in Future Update", pubDate: Date(), category: "AirPods", thumbnail: "https://images.macrumors.com/article-new/2020/11/windows-10.jpg",hypertTextContent: "HTML",author: "Anan Suliman")))
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
