//
//  MoviePosterWithNumber.swift
//  MovieDB
//
//  Created by Shubham on 02/07/25.
//

import SwiftUI

struct MoviePosterWithNumber: View {
    
    // MARK: - Variables
    var movie: MovieNW
    var index: Int
    
    var posterSize: MoviePosterHelper.ImageSize = .w300
    var width: CGFloat = 200
    var height: CGFloat = 200
    
    // MARK: - Views
    var body: some View {
        HStack(alignment: .bottom) {
            Text("\(index)")
                .font(Londrina.regular.font(size: 180))
                .offset(y: 36)
            
            URLImageView(imageURLString: movie.posterPath, width: width, height: height)
                .padding(.leading, -20)
        }
    }
}

#Preview {
    
    MoviePosterWithNumber(movie: testMovie, index: 1)
        .preferredColorScheme(.dark)
        .frame(width: 250, height: 240)
}

let testMovie: MovieNW = MovieNW(id: 230, title: "El Crack", overview: "El Crack is a 1981 Spanish crime drama film co-written and directed by José Luis Garci, starring Alfredo Landa. The plot was inspired by the novels written by Dashiell Hammett, to whom the film is dedicated.", posterPath: "https://image.tmdb.org/t/p/w500/kzgPu2CMxBr4YZZxC1Off4cUfR9.jpg", backdropPath: nil, releaseDate: "1994-04-03", voteAverage: 8.9)
