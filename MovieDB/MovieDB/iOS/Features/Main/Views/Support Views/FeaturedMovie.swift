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
//                    .overlay(alignment: .bottomLeading) {
//                        VStack(alignment: .leading, spacing: 12) {
//                            Text(movie.title ?? "")
//                                .font(ClashGrotestk.semibold.font(size: 24))
//                            
//                            HStack(spacing: 4) {
//                                Image(systemName: "star.fill")
//                                    .foregroundStyle(.yellow)
//                                    .font(.system(size: 18, weight: .medium))
//                                
//                                Text("\(movie.voteAverage.clean(places: 1))")
//                                    .font(Montserrat.medium.font(size: 18))
//                            }
//                        }
//                        .background {
//                            Rectangle()
//                                .frame(width: width)
//                        }
//                        .padding(24)
//                    }
            }
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FeaturedMovie(movie: testMovie)
}
