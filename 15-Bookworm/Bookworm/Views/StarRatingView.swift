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

    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                image(for: number)
                    .onTapGesture {
                        rating = number
                    }
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
