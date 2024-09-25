//
//  SeeAllHeaderView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct SeeAllHeaderView: View {
    let title: String
    let seeAll: String = "See all"
    var routeClosure: (Navigation) -> Void
    
    @Environment(\.navigation) var navigation
    
    var body: some View {
        HStack {
            Text(title)
                .layoutPriority(1)
            Button {
                routeClosure(navigation)
            } label: {
                HStack {
                    Text(seeAll)
                    Spacer()
                    Image(systemName: "arrow.right")
                }
            }
        }
    }
}

#Preview {
    SeeAllHeaderView(title: "Similar Movies", routeClosure: {_ in })
}
