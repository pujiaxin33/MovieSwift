//
//  MovieDetail.swift
//  SwiftMovieApp
//
//  Created by Jiaxin Pu on 2024/9/25.
//

import SwiftUI
import Networking

struct MovieDetailView: View {
    @State var viewModel: MovieDetailViewModel
    
    @Environment(\.navigation) private var navigation
    
    var body: some View {
        List {
            headerSection
            
            bottomSection
        }
        .navigationTitle(viewModel.movie.title)
        .navigationDestination(for: [Review].self, destination: { (reviews) in
            MovieReviewsView(reviews: reviews)
        })
        .onAppear {
            viewModel.loadData()
        }
    }
    
    var headerSection: some View {
        Section {
            MovieDetailBasicInfoHeaderView(movie: viewModel.movie)
            
            if let reviews = viewModel.reviews, !reviews.isEmpty {
                MovieDetailReviewsView(reviews: reviews)
            }
            
            MovieDetailOverviewView(movie: viewModel.movie)
        }
    }
    
    var bottomSection: some View {
        Section {
            if let keywords = viewModel.movie.keywords?.keywords, !keywords.isEmpty {
                KeywordsCardView(keywords: keywords)
            }
            
            if let cast = viewModel.cast {
                PeopleHorizontalListView(title: "Cast", peoples: cast.cast)
                PeopleHorizontalListView(title: "Crew", peoples: cast.crew)
            }
            
            if let movies = viewModel.similarMovies, !movies.isEmpty {
                SimilarMoviesView(movies: movies)
            }
        }
    }
}

struct RightIconLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center, spacing: 8) {
            configuration.title
            configuration.icon
        }
    }
}

#Preview {
    MovieDetailView(viewModel: .init(movie: sampleMovie))
}
