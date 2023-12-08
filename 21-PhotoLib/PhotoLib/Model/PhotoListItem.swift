//
//  PhotoListItem.swift
//  PhotoLib
//
//  Created by Eray Diler on 7.12.2023.
//

import UIKit

struct PhotoListItem: Identifiable {
    let id = UUID()
    var image: UIImage
    var name: String
    var location: Location?
}
