//
//  SpaceflightNewsService.swift
//  Spaceflight
//
//  Created by Vesela Stamenova on 9.03.23.
//

import Foundation

final class SpaceflightNewsService {

	private enum Constant {
		static let limitQueryParameter = "_limit"
	}

	func getArticles(limit: Int, completion: @escaping ([Article]?, Error?) -> Void) {
		let apiManager = APIManager()
		apiManager.run(
			path: "v3/articles",
			queryItems: [URLQueryItem(name: Constant.limitQueryParameter, value: "\(limit)")]
		) { data, error in
			guard let data = data else {
				completion(nil, error)
				return
			}
			let decoder = JSONDecoder()
			do {
				let articles = try decoder.decode([Article].self, from: data)
				completion(articles, nil)
			}
			catch {
				completion(nil, error)
			}
		}
	}
}
