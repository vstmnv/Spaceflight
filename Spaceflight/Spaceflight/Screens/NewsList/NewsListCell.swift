//
//  NewsListCell.swift
//  Spaceflight
//
//  Created by Vesela Stamenova on 9.03.23.
//

import UIKit

final class NewsListCell: UITableViewCell {

	@IBOutlet private weak var articleImageView: UIImageView!
	@IBOutlet private weak var titleLabel: UILabel!
	@IBOutlet private weak var descriptionLabel: UILabel!
	@IBOutlet private weak var newsSiteLabel: UILabel!
	@IBOutlet private weak var timestampLabel: UILabel!

	override func prepareForReuse() {
		super.prepareForReuse()
		articleImageView.image = nil
	}

	func configure(withArticle: Article) {
		titleLabel.text = withArticle.title
		descriptionLabel.text = withArticle.summary
		newsSiteLabel.text = withArticle.newsSite
		timestampLabel.text = getTimestamp(fromPublishedAt: withArticle.publishedAt)

		if let url = URL(string: withArticle.imageUrl) {
			let apiManager = APIManager()
			apiManager.run(url: url) { [weak self] data, error in
				if let data = data, let image = UIImage(data: data) {
					self?.articleImageView.image = image
				}
			}
		}
	}

	private func getTimestamp(fromPublishedAt: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSS'Z'"
		let date = dateFormatter.date(from: fromPublishedAt)
		return date?.formatted(date: .abbreviated, time: .shortened) ?? ""
	}
}

