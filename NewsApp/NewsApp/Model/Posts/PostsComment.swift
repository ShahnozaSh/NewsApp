//
//  PostsComment.swift
//  NewsApp
//
//  Created by Shahnoza on 14/3/22.
//

import Foundation

struct PostsComment: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
