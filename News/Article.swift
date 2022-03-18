//
//  Article.swift
//  News
//
//  Created by chavin Panicharoen on 19/3/2565 BE.
//

import Foundation

struct Article:Codable {
    var author:String?
    var title:String?
    var description:String?
    var url:String?
    var urlToImage:String?
    var publishedAt:String?
    var content:String?
}
