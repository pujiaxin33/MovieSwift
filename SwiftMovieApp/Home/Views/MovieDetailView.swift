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
        }
    }
    
    var movieBasicInfoHeader: some View {
        ZStack(alignment: .leading) {
            Color.gray
            
            VStack(alignment: .leading) {
                HStack {
                    if let path = viewModel.movie.poster_path {
                        AsyncImage(url: ImageService.posterUrl(path: path, size: .medium)) { image in
                            image.resizable()
                                .renderingMode(.original)
                                .posterStyle(loaded: true, size: .medium)
                        } placeholder: {
                            Color.green.posterStyle(loaded: true, size: .medium)
                        }
                    }
                    
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
                            .frame(height: 50)
                            .padding(.horizontal, 10)
                            .labelStyle(RightIconLabelStyle())
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                    }
                }
            }.frame(height: 100)
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
