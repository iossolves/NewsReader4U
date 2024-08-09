//
//  ArticleDetailView.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI

struct ArticleDetailView: View {
    @ObservedObject var viewModel: ArticleDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                if let imageURLString = viewModel.article.urlToImage,
                   let imageUrl = URL(string: imageURLString) {
                    AsyncImage(url: imageUrl) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable().scaledToFit()
                        case .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .clipped()
                                .padding()
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .padding()
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                        .padding()
                }
                
                HStack {
                    HStack {
                        Image(systemName: "person")
                            .font(.system(size: 15))
                        Text("\(viewModel.article.displayAuthor)")
                            .font(.system(size: 15))
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "calendar")
                            .font(.system(size: 16))
                        Text("\(viewModel.article.publishedDate)")
                            .font(.system(size: 16))
                    }
                }
                .padding()
                
                Spacer()
                
                Text("\(viewModel.article.displayContent)")
                    .font(.system(size: 18))
                
                Spacer(minLength: 32)

                Button(action: viewModel.openArticleUrl) {
                    Text("READ MORE")
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .frame(maxWidth: .infinity)
                }
                .background(.black)
            }
        }
        .padding()
        .navigationBarTitle(viewModel.article.displayTitle)
    }
}
