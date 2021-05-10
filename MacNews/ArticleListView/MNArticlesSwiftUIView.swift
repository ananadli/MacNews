//
//  MNArticlesSwiftUIView.swift
//  MacNews
//
//  Created by Anan Suliman on 02/05/2021.
//

import SwiftUI
import SDWebImageSwiftUI
struct MNArticlesSwiftUIView: View {
    @ObservedObject var viewModel = MNArticleViewModel()
    @AppStorage(UserDefaultsKeys.BookmarkedArticles.rawValue) var bookmarkList : [String] = []
    @State var  bookmarkFilter : Int = 1
    
    @EnvironmentObject var deepLinkManeger : MNDeepLinkManeger
    var body: some View {
      
            NavigationView {
               
            ZStack {
                //** Handle opening the artical from external URL NOTE the $deepLinkManeger.shouldOpen blinding it must be handled by automatically (False case) the navigation
                if deepLinkManeger.openArticleRequest != nil {
                NavigationLink(
                    destination: MNArticleDetailsSwiftUIView(viewModel: MNArticleDetailsViewModel(article: MNArticleModel(idPath: (deepLinkManeger.openArticleRequest?.articlePathId)!))),
                    isActive: $deepLinkManeger.shouldOpen,
                    label: {
                        
                    })
                }//**
                
                //Changing Background Color
                Color("background-color").ignoresSafeArea()
               
                 
                VStack(alignment: .center, spacing: 0, content: {
                    
                //Placing a custom navigation view
                    MNArticleListNavigationView(bookmarkFilter: $bookmarkFilter, viewModel: viewModel)
                    
                    ScrollView(.vertical, showsIndicators: true, content: {

                    LazyVStack(alignment: .leading, spacing: 0, content: {
                                    
                            
                                    ForEach(viewModel.articles, id: \.id) { item in
                                        //Check if bookmark filter is selected
                                        if bookmarkFilter == 2   {
                                            //check if the article is bookmarked
                                            if bookmarkList.contains(item.idPath) {
                                                //Article is Bookmarked
                                    MNArticleListItemView(article: item)
                                            }
                                        }else{
                                            //Display all artical
                                            MNArticleListItemView(article: item)
                                        }
                                }

                            })

                    })
                    Spacer()

                })
              //This alert to display errors and the $viewModel.isError binding it must be handled by the alert (False Case)
            }.alert(isPresented: $viewModel.isError, content: {
                Alert(title: Text("Error"), message: Text(viewModel.error?.localizedDescription ?? "Error Accrued"), dismissButton: .default(Text("Ok")))
            }).ignoresSafeArea(.all, edges: .bottom).navigationBarHidden(true)
                
            }
        
        
}
  
}

struct MNArticlesSwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        MNArticlesSwiftUIView( ).environmentObject(MNDeepLinkManeger())
    }
}

struct MNArticleListItemView: View {
    
    var article : MNArticleModel

    var body: some View {
        NavigationLink(
            destination: MNArticleDetailsSwiftUIView(viewModel: MNArticleDetailsViewModel(article: article)),
            label: {
                
           
        HStack(alignment: .center, spacing: 0, content: {
            
            WebImage(url: URL(string: article.thumbnail)).resizable().scaledToFill().frame(width: 90, height: 120, alignment: .center).background(Color(.lightGray)).cornerRadius(10).clipped().padding(.trailing, 10)
            
            
            VStack(alignment: .leading, spacing: 0, content: {
                VStack(alignment: .leading, spacing: 3, content: {
                    Text(article.category).font(.callout).foregroundColor(Color("category-color-text")).multilineTextAlignment(.leading)
                    Text(article.title).font(.headline).foregroundColor(.black).multilineTextAlignment(.leading)
                    Spacer()

                    MNArticleRelativeDateView(article: article)
                })
                
                
            })
           Spacer()
        }).padding()
            })
    }
}

struct MNArticleRelativeDateView: View {
    var article : MNArticleModel
    var body: some View {
        HStack(alignment: .center, spacing: 5, content: {
            Image(systemName: "clock.fill").foregroundColor(Color("subtitle-color")).font(.subheadline)
            
            Text( article.getRelativePubDateFormat()).foregroundColor(Color("subtitle-color")).font(.subheadline)
        })
    }
}

struct MNArticleListNavigationView: View {
    @Binding var bookmarkFilter : Int
    @ObservedObject var viewModel : MNArticleViewModel
    @State var showAboutView : Bool = false
    
    var body: some View {
        VStack(alignment: .center, spacing: nil, content: {
            HStack {
                Button(action: {
                    showAboutView.toggle()
                }, label: {
                    Image(systemName: "info.circle").foregroundColor(.black).font(.system(size: 25, weight: .medium, design: .default))
                })
                Spacer()
                
                Button(action: {
                    
                    viewModel.fetchAllArticles()
                }, label: {
                    ZStack{
                    if viewModel.isLoading{
                        ProgressView().foregroundColor(.black)
                    }else{
                        Image(systemName: "arrow.clockwise") .foregroundColor(.black).font(.system(size: 25, weight: .medium, design: .default))
                        
                    }
                    }
                })
                
                
            }
            HStack {
                Text("Articles").font(.system(size: 30, weight: .bold, design: .default)).foregroundColor(.black).multilineTextAlignment(.leading)
                Spacer()
             

            }
            
            Picker(selection: $bookmarkFilter, label: Text("Picker"), content: {
                Text("All").tag(1)
                Text("Bookmarked").tag(2)
            }).pickerStyle(SegmentedPickerStyle()).accentColor(.black)
        }).sheet(isPresented: $showAboutView, content: {
            MNAboutSwiftUIView(showAboutView: $showAboutView)
        }).padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
    }
}
