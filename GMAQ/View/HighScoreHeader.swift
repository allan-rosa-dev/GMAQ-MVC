//
//  HighScoreHeader.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/01/22.
//

import UIKit


class HighScoreHeader: UITableViewHeaderFooterView {
	
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.textColor = K.Design.fontColor
		label.font = UIFont(name: K.Design.fontNameBold, size: 30)
		label.text = "Player Name"
		label.textColor = K.Design.backgroundColor
		
		return label
	}()
	
	lazy var scoreLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.numberOfLines = 1
		label.textColor = K.Design.fontColor
		label.font = UIFont(name: K.Design.fontNameBold, size: 30)
		label.text = "Score"
		label.textAlignment = .right
		label.textColor = K.Design.backgroundColor
		
		return label
	}()
	
	lazy var controlStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.translatesAutoresizingMaskIntoConstraints = false
		stackview.axis = .horizontal
		stackview.distribution = .fillProportionally
		stackview.alignment = .fill
		
		return stackview
	}()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		buildViewHierarchy()
		setupConstraints()
		configureViews()
	}
	
	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func buildViewHierarchy() {
		controlStackView.addArrangedSubview(nameLabel)
		controlStackView.addArrangedSubview(scoreLabel)
		contentView.addSubview(controlStackView)
	}
	
	private func setupConstraints() {
		let priority = UILayoutPriority(999)
		let topConstraint = controlStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
		let leadingConstraint = controlStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
//		leadingConstraint.priority = priority
		let trailingConstraint = controlStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
		trailingConstraint.priority = priority
		let bottomConstraint = controlStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
		
		NSLayoutConstraint.activate([
			topConstraint, leadingConstraint, trailingConstraint, bottomConstraint
		])
	}
	
	private func configureViews(){
		contentView.backgroundColor = K.Design.fontColor
	}
}
