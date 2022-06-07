//
//  Model.swift
//  NewsAppCollectionView
//
//  Created by naruto kurama on 29.04.2022.
//

import Foundation

struct APIResponse : Codable {
    let articles : [Article]
    
    init(dictionary : [String : Any]) {
        self.articles = dictionary["articles"] as! [Article]
    }
}
struct Article : Codable {
    let source : Source
    let title : String
    let description : String
    let url : String
    let urlToImage : String
    let publishedAt : String
    
    init(dictionary : [String : Any]) {
        self.source = dictionary["source"] as! Source
        self.title = dictionary["title"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        self.urlToImage = dictionary["urlToImage"] as? String ?? ""
        self.publishedAt = dictionary["publishedAt"] as? String ?? ""
    }
}
struct Source : Codable {
    let name : String
    
    init(dictionary : [String : String]) {
        self.name = dictionary["name"] ?? ""
    }
}


