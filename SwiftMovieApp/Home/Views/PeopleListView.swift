//
//  PeopleListView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI

struct PeopleListView: View {
    let naviTitle: String
    let peoples: [People]
    var body: some View {
        List(peoples) { people in
            PeopleCardView(people: people)
        }
        .navigationTitle(naviTitle)
    }
}

struct PeopleCardView: View {
    let people: People
    var body: some View {
        NavigationLink(value: people) {
            HStack {
                MoviePosterView(path: people.profile_path, urlSize: .medium, size: .medium)
                
                VStack(alignment: .leading) {
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

#Preview {
    PeopleListView(naviTitle: "test", peoples: [])
}
