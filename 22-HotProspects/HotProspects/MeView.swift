//
//  MeView.swift
//  HotProspects
//
//  Created by Eray Diler on 10.12.2023.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    @State private var qrCode = UIImage()

    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                Form {
                    TextField("Name", text: $name)
                        .textContentType(.name)
                        .font(.title)

                    TextField("Email address", text: $emailAddress)
                        .textContentType(.emailAddress)
                        .font(.title)

                    ZStack {
                        HStack {
                            Spacer()
                            Image(uiImage: qrCode)
                                .interpolation(.none)
                                .resizable()
                                .scaledToFit()
                                .frame(
                                    width: geo.size.height * 0.3,
                                    height: geo.size.height * 0.3
                                )
                                .contextMenu {
                                    Button {
                                        let imageSaver = ImageSaver()
                                        imageSaver.writeToPhotoAlbum(image: qrCode)
                                    } label: {
                                        Label("Save to Photos", systemImage: "square.and.arrow.down")
                                    }
                                }
                            Spacer()
                        }
                    }
                    .zIndex(1)
                    .frame(minHeight: geo.size.height * 0.5)
                }
            }
            .navigationTitle("Your code")
            .onAppear(perform: updateQRCode)
            .onChange(of: name) { updateQRCode() }
            .onChange(of: emailAddress) { updateQRCode() }
        }
    }

    private func updateQRCode() {
        qrCode = generateQRCode(from: "\(name)\n\(emailAddress)")
    }

    private func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    MeView()
}
