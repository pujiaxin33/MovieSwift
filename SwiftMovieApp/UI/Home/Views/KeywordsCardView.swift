//
//  KeywordsCardView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct KeywordsCardView: View {
    let keywords: [Keyword]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Keywords")
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(keywords) { keyword in
                        Label(keyword.name, systemImage: "arrow.right")
                            .frame(height: 30)
                            .padding(.horizontal, 10)
                            .labelStyle(RightIconLabelStyle())
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                    }
                }
            }.frame(height: 50)
        }
    }
}

#Preview {
    KeywordsCardView(keywords: [])
}
