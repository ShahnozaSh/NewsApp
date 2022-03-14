//
//  PostsImage.swift
//  NewsApp
//
//  Created by Shahnoza on 14/3/22.
//

import Foundation

struct PostsImage: Requestable {
    let id: Int
    let url: String?
    
    static var urlRequest: URLRequest {
        let url = URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos")!
        let request = URLRequest(url: url)
        return request
    }
}
