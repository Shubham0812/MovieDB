//
//  SearchMoviesView.swift
//  MovieDB
//
//  Created by Shubham on 04/07/25.
//

import SwiftUI

struct SearchMoviesView: View {
    
    // MARK: - Variables
    @Environment(\.managedObjectContext) private var managedObjectContext
    @State var searchViewModel: SearchViewModel = .init()
    
    @EnvironmentObject var genreService: GenreService
    @EnvironmentObject var mainViewModel: MainViewModel

    // MARK: - Views
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                ZStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(searchViewModel.searchedMovies) { movie in
                                NavigationLink(value: movie) {
                                    MovieListView(movie: movie, movieGenre: genreService.getGenres(from: movie.genreIDs), addAction: {
                                        searchViewModel.favoriteMovie(movieNW: movie)
                                    }, removeAction: {
                                        searchViewModel.unfavoriteMovie(movieID: movie.id)
                                    })
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                    }
                    .scrollDismissesKeyboard(.interactively)
                }
            }
            .searchable(text: $searchViewModel.searchText, prompt: "Search movies") {
                ForEach(searchViewModel.searchedMovies.prefix(3)) { movie in
                    Text(movie.title ?? "")
                        .searchCompletion(movie.title ?? "") // Auto-completes on tap
                }
            }
            .navigationDestination(for: MovieNW.self) { movie in
                MovieDetailView(movie: movie)
                    .environmentObject(mainViewModel)
            }
            .onAppear() {
                searchViewModel.updateContext(managedObjectContext)

            }
        }
    }
}

#Preview {
    SearchMoviesView()
        .environmentObject(GenreService())
}
