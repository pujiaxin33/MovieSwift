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
    
    @State private var isOverviewFolded: Bool = true
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
            movieBasicInfoHeader
            
            reviewsView
            
            overviewHeader
        }
    }
    
    var bottomSection: some View {
        Section {
            if let keywords = viewModel.movie.keywords?.keywords, !keywords.isEmpty {
                keyboardView(keywords: keywords)
            }
            
            if let cast = viewModel.cast {
                castCrewListView(cast: cast)
            }
            
            if let movies = viewModel.similarMovies, !movies.isEmpty {
                SimilarMoviesView(movies: movies)
            }
        }
    }
    
    var movieBasicInfoHeader: some View {
        ZStack(alignment: .leading) {
            Color.gray
            
            VStack(alignment: .leading) {
                HStack {
                    MoviePosterView(path: viewModel.movie.poster_path, urlSize: .medium, size: .medium)
                    
                    VStack(alignment: .leading) {
                        Text(viewModel.movie.yearDurationStatusDisplayTitle).foregroundStyle(Color.red).background(Color.cyan).font(.system(size: 12))
                        if let countryName = viewModel.movie.production_countries?.first?.name {
                            Text(countryName)
                        }
                        Text("\(viewModel.movie.voteAverageText) \(viewModel.movie.voteCountText)")
                    }
                }
                
                if let genres = viewModel.movie.genres {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(genres) { genre in
                                Button(genre.name) {
                                    print(genre.name)
                                }
                            }
                        }
                    }
                }
                
            }
        }.listRowInsets(EdgeInsets())
    }
    
    var reviewsView: some View {
        Group {
            if let reviews = viewModel.reviews, !reviews.isEmpty {
                HStack {
                    Text("\(reviews.count) reviews")
                    Spacer()
                    Image(systemName: "arrow.right")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    navigation.path.append(reviews)
                }
            }
        }
    }
    
    var overviewHeader: some View {
        VStack(alignment: .leading) {
            Text("Overview").font(.system(size: 15, weight: .bold))
            
            Text(viewModel.movie.overview)
                .foregroundStyle(Color.gray.opacity(0.5))
                .lineLimit(isOverviewFolded ? 4 : nil)
            
            Button(isOverviewFolded ? "Readmore" : "Less") {
                isOverviewFolded.toggle()
            }
            .foregroundStyle(Color.blue)
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    func keyboardView(keywords: [Keyword]) -> some View {
        VStack {
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
    
    func castCrewListView(cast: CastResponse) -> some View {
        VStack {
            VStack {
                Text("Cast")
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(cast.cast) { people in
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
            
            VStack {
                Text("Cew")
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(cast.crew) { people in
                            VStack {
                                MoviePosterView(path: people.profile_path, urlSize: .cast, size: .medium)
                                
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
