//
//  URLImageView.swift
//  MovieDB
//
//  Created by Shubham on 01/07/25.
//

import SwiftUI

struct URLImageView: View {
    // MARK: - Variables
    let imageURLString: String?
    let width: CGFloat
    let height: CGFloat
    var cornerRadius: CGFloat = 8
    var posterSize: MoviePosterHelper.ImageSize = .w200

    @State private var uiImage: UIImage?

    private var placeholderView: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.gray.opacity(0.25))
            .frame(width: width, height: height)
    }

    private var imageURL: URL? {
        guard let path = imageURLString else { return nil }
        return MoviePosterHelper.posterURL(path: path, size: posterSize)
    }

    // MARK: - Views
    var body: some View {
        Group {
            if let uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height, alignment: .top)
                    .clipped()
                    .cornerRadius(cornerRadius)
            } else {
                placeholderView
            }
        }
        .onAppear {
            loadImage()
        }
    }

    private func loadImage() {
        guard let url = imageURL else { return }

        if let cachedImage = ImageCache.shared.image(for: url) {
            self.uiImage = cachedImage
            return
        }

        Task {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                if let image = UIImage(data: data) {
                    ImageCache.shared.setImage(image, for: url)
                    await MainActor.run {
                        self.uiImage = image
                    }
                }
            } catch {
                fatalError()
            }
        }
    }
}
