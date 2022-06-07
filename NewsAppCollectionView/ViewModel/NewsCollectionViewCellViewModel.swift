//
//  NewsCollectionViewCellViewModel.swift
//  NewsAppCollectionView
//
//  Created by naruto kurama on 29.04.2022.
//

import Foundation

class NewsCollectionViewCellViewModel {
    
    let title : String
    let description : String
    let imageURL : URL?
    var imageData : Data? = nil
    
    init(title : String, description : String, imageURL: URL?) {
        self.title = title
        self.description = description
        self.imageURL = imageURL
    }
}
