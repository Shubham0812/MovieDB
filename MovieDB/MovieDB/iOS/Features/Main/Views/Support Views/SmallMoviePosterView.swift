//
//  SmallMoviePosterView.swift
//  MovieDB
//
//  Created by Shubham on 01/07/25.
//

import SwiftUI

struct SmallMoviePosterView: View {
    
    // MARK: - Variables
    @EnvironmentObject var mainViewModel: MainViewModel
    
    @State var movie: MovieNW
    
    var posterSize: MoviePosterHelper.ImageSize = .w300
    var width: CGFloat = 200
    var height: CGFloat = 200
    
    // MARK: - Views
    var body: some View {
        NavigationLink(value: movie) {
            VStack {
                URLImageView(imageURLString: movie.posterPath, width: width, height: height)
            }
            .contextMenu {
                Button(action: {
                    movie.isFavorite.toggle()
                    mainViewModel.saveMovie(movieNW: movie)
                }) {
                    Label(movie.isFavorite ? "Remove from Favorites" : "Add to Favorites", systemImage: movie.isFavorite ? "heart" : "heart.fill")
                }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {    
    SmallMoviePosterView(movie: testMovie)
        .environmentObject(MainViewModel())
}
