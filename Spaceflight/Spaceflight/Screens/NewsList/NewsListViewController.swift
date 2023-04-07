//
//  NewsListViewController.swift
//  Spaceflight
//
//  Created by Vesela Stamenova on 9.03.23.
//

import UIKit

final class NewsListViewController: UIViewController {

	private enum Constant {
		static let newsCellIdentifier = "newsCell"
		static let showDetailsSegue = "showArticleDetails"
	}

	@IBOutlet private weak var tableView: UITableView!

	private var articles: [Article] = []
	private let refreshControl = UIRefreshControl()

	override func viewDidLoad() {
		super.viewDidLoad()
		getArticles()
		setUpPullToRefresh()
	}

	// MARK: - Navigation

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		switch segue.identifier {
		case Constant.showDetailsSegue:
			if let detailsController = segue.destination as? NewsDetailsViewController,
				let articleUrl = sender as? String {
				detailsController.configure(withUrl: articleUrl)
			}
		default:
			break
		}
	}

	// MARK: - Private

	private func setUpPullToRefresh() {
		tableView.refreshControl = refreshControl
		refreshControl.addTarget(self, action: #selector(getArticles), for: .valueChanged)
	}

	@objc private func getArticles() {
		let service = SpaceflightNewsService()
		service.getArticles(limit: 50) { [weak self] articles, error in
			if let articles = articles {
				self?.articles = articles
				self?.tableView.reloadData()
				self?.refreshControl.endRefreshing()
			}
		}
	}
}

// MARK: - UITableViewDataSource

extension NewsListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articles.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let newsCell = tableView.dequeueReusableCell(withIdentifier: Constant.newsCellIdentifier, for: indexPath) as? NewsListCell else {
			return UITableViewCell()
		}

		let article = articles[indexPath.row]
		newsCell.configure(withArticle: article)

		return newsCell
	}
}

// MARK: - UITableViewDelegate

extension NewsListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let article = articles[indexPath.row]
		performSegue(withIdentifier: Constant.showDetailsSegue, sender: article.url)
	}
}
