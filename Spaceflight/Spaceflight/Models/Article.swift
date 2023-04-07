//
//  Article.swift
//  Spaceflight
//
//  Created by Vesela Stamenova on 9.03.23.
//

import Foundation

struct Article: Decodable {
	let id: Int
	let url: String
	let title: String
	let imageUrl: String
	let newsSite: String
	let summary: String
	let publishedAt: String
}
