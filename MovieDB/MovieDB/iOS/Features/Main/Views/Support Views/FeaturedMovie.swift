//
//  FeaturedMovie.swift
//  MovieDB
//
//  Created by Shubham on 02/07/25.
//

import SwiftUI

struct FeaturedMovie: View {
    
    // MARK: - Variables
    var movie: MovieNW
    var posterSize: MoviePosterHelper.ImageSize = .w500

    var cornerRadius: CGFloat = 8
    
    // MARK: - Views
    var body: some View {
        NavigationLink(value: movie) {
            GeometryReader { proxy in
                let width: CGFloat = proxy.size.width
                let height: CGFloat = proxy.size.height
                
                URLImageView(imageURLString: movie.posterPath, width: width, height: height, cornerRadius: cornerRadius)
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FeaturedMovie(movie: testMovie)
}
