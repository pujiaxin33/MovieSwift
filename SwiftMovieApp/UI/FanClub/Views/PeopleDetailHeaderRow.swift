//
//  PeopleDetailHeaderRow.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct PeopleDetailHeaderRow: View {
    let people: People
    
    var body: some View {
        HStack(alignment: .top) {
            MoviePosterView(path: people.profile_path, size: .medium)
            
            VStack(alignment: .leading) {
                Text("Known for")
                
                if people.known_for_department != nil{
                    Text(people.known_for_department!)
                }
                Text(people.knownForText ?? "For now nothing much... or missing data")
                    .foregroundColor(.secondary)
                    .font(.body)
                    .lineLimit(nil)
            }
            .padding(.leading, 8)
            .padding(.top, 8)
        }
    }
}
