//
//  ArticleRowView.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI

struct ArticleRowView: View {
    
    let article: Article
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 100)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                    case .failure:
                        Image(systemName: "photo")
                            .frame(width: 100, height: 100)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .frame(width: 100, height: 100)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.displayTitle)
                    .font(.headline)
                    .lineLimit(2)
                HStack {
                    Image(systemName: "person")
                        .font(.system(size: 12))
                    Text("\(article.displayAuthor)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 12))
                    Text(article.publishedDate)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

            }
        }
        .padding(.vertical, 8)
    }
}

