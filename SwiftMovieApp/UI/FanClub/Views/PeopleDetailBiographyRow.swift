//
//  PeopleDetailBiographyRow.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct PeopleDetailBiographyRow: View {
    let people: People
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if people.biography != nil {
                Text("Biography")
                    .lineLimit(1)
                Text(people.biography!)
                    .foregroundColor(.secondary)
                    .font(.body)
                    .lineLimit(isExpanded ? 1000 : 4)
            }
            Button(action: {
                self.isExpanded.toggle()
            }) {
                Text(isExpanded ? "Less": "Read more").foregroundColor(Color.blue)
            }
            if people.birthDay != nil {
                Text("Birthday")
                    .lineLimit(1)
                Text(people.birthDay!)
                    .foregroundColor(.secondary)
                    .font(.body)
                    .lineLimit(1)
            }
            if people.place_of_birth != nil {
                Text("Place of birth")
                    .lineLimit(1)
                Text(people.place_of_birth!)
                    .foregroundColor(.secondary)
                    .font(.body)
                    .lineLimit(1)
            }
            if people.deathDay != nil {
                Text("Day of deah")
                    .lineLimit(1)
                Text(people.deathDay!)
                    .foregroundColor(.secondary)
                    .font(.body)
                    .lineLimit(1)
            }
        }
    }
}
