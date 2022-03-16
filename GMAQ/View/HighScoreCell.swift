//
//  HighScoreCell.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/01/22.
//

import UIKit


class HighScoreCell: UITableViewCell {
	
	lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textColor = K.Design.fontColor
		label.font = UIFont(name: K.Design.fontName, size: 20)
		
		return label
	}()
	
	lazy var scoreLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 1
		label.textColor = K.Design.fontColor
		label.font = UIFont(name: K.Design.fontName, size: 22)
		label.textAlignment = .right
		
		return label
	}()
	
	lazy var controlStackView: UIStackView = {
		let stackview = UIStackView()
		stackview.translatesAutoresizingMaskIntoConstraints = false
		stackview.axis = .horizontal
		stackview.distribution = .fillProportionally
		stackview.alignment = .fill
		stackview.spacing = 8
		
		return stackview
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		buildViewHierarchy()
		setupConstraints()
	}
	
	@available(*, unavailable)
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func buildViewHierarchy() {
		contentView.addSubview(controlStackView)
		controlStackView.addArrangedSubview(nameLabel)
		controlStackView.addArrangedSubview(scoreLabel)
	}
	
	private func setupConstraints() {
		let padding: CGFloat = 8
		NSLayoutConstraint.activate([
			controlStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
			controlStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
			controlStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
			controlStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
		])
	}
	
	func configureView(withScoreRecord scoreRecord: ScoreRecord) {
		nameLabel.text = scoreRecord.username
		scoreLabel.text = String(scoreRecord.score)
	}
}
