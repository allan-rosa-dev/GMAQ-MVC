//
//  QuizBreakdownCell.swift
//  GMAQ
//
//  Created by Allan Rosa on 22/09/21.
//

import UIKit

class QuizBreakdownCell: UITableViewCell {
	private enum Layout {
		static let margin: CGFloat = 10
		static let halfMargin: CGFloat = margin/2
	}
	
	var isDisplayingOriginalAnswer = true
	
	private lazy var informationStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.distribution = .fillProportionally
		stackView.alignment = .fill
		stackView.spacing = 5
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
	
	private lazy var numberLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = K.Design.fontColor
		label.font = UIFont(name: K.Design.fontName, size: 46)
		label.text = "xd"
		
		return label
	}()
	
	private lazy var questionTextStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.distribution = .equalSpacing
		stackView.alignment = .fill
		stackView.spacing = Layout.halfMargin
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		return stackView
	}()
		
	private lazy var questionLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = K.Design.fontColor
		label.font = UIFont(name: K.Design.fontNameBold, size: 16)
		label.text = "Lorem ipsum "
		label.textAlignment = .justified
		label.preferredMaxLayoutWidth = questionTextStackView.frame.width
		
		return label
	}()
	
	lazy var answerLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textColor = UIColor.appColor(.black)
		label.font = UIFont(name: K.Design.fontNameBold, size: 16)
		label.text = "Fake"
		label.textAlignment = .justified
		label.preferredMaxLayoutWidth = questionTextStackView.frame.width*1.5
		
		return label
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
		questionTextStackView.addArrangedSubview(questionLabel)
		questionTextStackView.addArrangedSubview(answerLabel)

//		informationStackView.addArrangedSubview(questionTextStackView)
//		informationStackView.addArrangedSubview(numberLabel)

//		contentView.addSubview(informationStackView)
		contentView.addSubview(questionTextStackView)
	}
	
	private func setupConstraints() {
		
		NSLayoutConstraint.activate([
			questionTextStackView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: Layout.margin),
			questionTextStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.margin),
			questionTextStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.margin),
			questionTextStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -Layout.margin),
			questionTextStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			//questionTextStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
		])
		
		NSLayoutConstraint.activate([
			answerLabel.leadingAnchor.constraint(equalTo: questionTextStackView.leadingAnchor),
			answerLabel.trailingAnchor.constraint(equalTo: questionTextStackView.trailingAnchor)
		])
	}
	
	func configureView(withQuestion question: Question, withUserAnswer answer: Answer, withNumber number: Int) {
		questionLabel.text = question.text
		answerLabel.text = answer.text
		numberLabel.text = String(number)

		if answer.isCorrect {
			backgroundColor = UIColor.appColor(.green)
			questionLabel.textColor = UIColor.appColor(.black)
			answerLabel.textColor = UIColor.appColor(.black)
			numberLabel.textColor = UIColor.appColor(.black)
		}
		else {
			backgroundColor = UIColor.appColor(.red)
			questionLabel.textColor = UIColor.appColor(.white)
			answerLabel.textColor = UIColor.appColor(.white)
			numberLabel.textColor = UIColor.appColor(.white)
		}
	}
	
	func toggleAnswer(with answer: Answer){
		if answer.isCorrect {
			answerLabel.text = "Correct Answer: " + answer.text
			contentView.backgroundColor = UIColor.appColor(.blue)
		}
		else {
			answerLabel.text = answer.text
			contentView.backgroundColor = UIColor.appColor(.red)
		}
	}
}
