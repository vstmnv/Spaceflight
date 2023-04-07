//
//  NewsDetailsViewController.swift
//  Spaceflight
//
//  Created by Vesela Stamenova on 9.03.23.
//

import UIKit
import WebKit

final class NewsDetailsViewController: UIViewController {

	@IBOutlet private weak var webView: WKWebView!

	private var url: String?

	override func viewDidLoad() {
		super.viewDidLoad()
		loadArticleInWebView()
	}

	// MARK: - Public

	func configure(withUrl: String) {
		self.url = withUrl
	}

	// MARK: - Private

	private func loadArticleInWebView() {
		guard let articleUrl = url, let url = URL(string: articleUrl) else {
			return
		}
		let request = URLRequest(url: url)
		webView.load(request)
	}
}
