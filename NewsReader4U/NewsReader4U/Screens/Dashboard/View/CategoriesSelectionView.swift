//
//  CategoriesSelectionView.swift
//  NewsReader4U
//
//  Created by Karunakar Bandikatla on 09/08/24.
//

import SwiftUI

struct CategoriesSelectionView: View {
    @Binding var selectedId: Int
    let categories: [ArticleCategory]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top) {
                ForEach(categories, id: \.self) { category in
                    VStack {
                        Text(category.displayName)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundColor(selectedId == category.id ? .white : .black)
                            .background(selectedId == category.id ? Color.blue : Color.gray)
                            .cornerRadius(8)
                            .onTapGesture {
                                selectedId = category.id
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
