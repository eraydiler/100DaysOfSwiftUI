//
//  StarRatingView.swift
//  Bookworm
//
//  Created by Eray Diler on 20.10.2023.
//

import SwiftUI

struct StarRatingView: View {
    @Binding var rating: Int

    var activeColor: Color = .yellow
    var inactiveColor: Color = .gray
    var inactiveImage: Image?
    var activeImage: Image = Image(systemName: "star.fill")
    private let maximumRating = 5

    var body: some View {
        HStack {
            ForEach(1...maximumRating, id: \.self) { number in
                image(for: number)
                    .onTapGesture {
                        rating = number
                    }
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Rating")
        .accessibilityValue(rating == 1 ? "1 star" : "\(rating) stars")
        .accessibilityAdjustableAction { direction in
            switch direction {
            case .increment:
                if rating < maximumRating { rating += 1 }
            case .decrement:
                if rating > 1 { rating -= 1 }
            default:
                break
            }
        }
    }

    private func image(for number: Int) -> some View {
        if number <= rating {
            return activeImage.foregroundStyle(activeColor)
        } else {
            return (inactiveImage ?? activeImage).foregroundStyle(inactiveColor)
        }
    }
}

#Preview {
    StarRatingView(rating: Binding.constant(3))
}
