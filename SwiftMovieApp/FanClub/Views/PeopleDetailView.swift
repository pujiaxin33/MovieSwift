//
//  PeopleDetailView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct PeopleDetailView: View {
    let viewModel: PeopleDetailViewModel
    @Environment(\.favoritePeopleManager) var favoritePeopleManager: FavoritePeopleManager
    
    var body: some View {
        List {
            basicInfoSection
            
            if let movieByYears = viewModel.movieByYears {
                ForEach(Array(movieByYears.keys), id: \.self) { year in
                    moviesSection(year: year, movies: movieByYears[year]!)
                }
            }
            
        }
        .navigationTitle(viewModel.people.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoritePeopleManager.insert(viewModel.people)
                } label: {
                    Image(systemName: viewModel.isFavoritePeople(people: viewModel.people, favoritePeoples: favoritePeopleManager.peoples) ? "star.circle.fill" : "star.circle")
                }

            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }
    
    var basicInfoSection: some View {
        Section {
            PeopleDetailHeaderRow(people: viewModel.people)
            
            if viewModel.checkCanShowBiography(people: viewModel.people) {
                PeopleDetailBiographyRow(people: viewModel.people)
            }
            
            if let images = viewModel.people.images, !images.isEmpty {
                PeopleDetailImagesRow(images: images)
            }
        }
    }
    
    func moviesSection(year: String, movies: [Movie]) -> some View {
        Section {
            ForEach(movies) { movie in
                PeopleDetailMovieRow(movie: movie)
            }
        } header: {
            Text(year)
        }

    }
}
