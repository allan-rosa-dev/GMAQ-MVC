//
//  QuizBreakdownHeader.swift
//  GMAQ
//
//  Created by Allan Rosa on 28/09/21.
//

import UIKit

class QuizBreakdownHeader: UITableViewHeaderFooterView {
	// MARK: - Attributes
	lazy var title: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.appColor(.white)
		label.font = UIFont(name: K.Design.fontNameBold, size: 20)
		label.translatesAutoresizingMaskIntoConstraints = false
		
		return label
	}()
	
	override init(reuseIdentifier: String?){
		super.init(reuseIdentifier: reuseIdentifier)

		buildViewHierarchy()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func buildViewHierarchy(){
		contentView.addSubview(title)
	}
	
	func setupConstraints(){
		NSLayoutConstraint.activate([
			title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
			title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
		])
	}
}
