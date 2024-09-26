//
//  PeopleListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct PeoplesListCardView: View {
    let title: String
    let peoples: [People]
    
    var body: some View {
        VStack {
            SeeAllHeaderView(title: title) { navi in
                navi.path.append(PeopleListPath(naviTitle: title, peoples: peoples))
            }
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(peoples) { people in
                        VStack {
                            MoviePosterView(path: people.profile_path, urlSize: .medium, size: .medium)
                            
                            Text(people.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            
                            Text(people.character ?? people.department ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PeoplesListCardView(title: "Cast", peoples: [])
}
