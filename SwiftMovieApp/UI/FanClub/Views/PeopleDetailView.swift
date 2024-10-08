//
//  PeopleDetailView.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/26.
//

import SwiftUI

struct PeopleDetailView: View {
    let viewModel: PeopleDetailViewModel
    
    var body: some View {
        List {
            basicInfoSection
            
            if let movieByYears = viewModel.movieByYears {
                ForEach(Array(movieByYears), id: \.self) { data in
                    moviesSection(year: data.year, movies: data.movies)
                }
            }
            
        }
        .navigationTitle(viewModel.people.name)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if viewModel.isFavoritePeople(people: viewModel.people) {
                        viewModel.unfavoritePeople(viewModel.people)
                    } else {
                        viewModel.favoritePeople(viewModel.people)
                    }
                } label: {
                    Image(systemName: viewModel.isFavoritePeople(people: viewModel.people) ? "star.circle.fill" : "star.circle")
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
