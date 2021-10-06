//
//  GameResultViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class GameResultViewController: UIViewController {

	// MARK: - Properties
	var quiz = Quiz(from: [Question()]) {
		didSet {
			isOriginalAnswer = Array(repeating: true, count: quiz.questions.count)
		}
	}
	var isOriginalAnswer: [Bool] = []
	// var quiz = Quiz(from: [])
	
	@IBOutlet weak var resultsLabel: UILabel!
	@IBOutlet weak var quizBreakdownTableView: UITableView!
	@IBOutlet weak var nameTextField: UITextField!
	
	//MARK: - Lifecyle
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.isNavigationBarHidden = true
		initializeHideKeyboard()
		configureTableView()
    }
	
	// MARK: - Methods
	fileprivate func configureTableView(){
		quizBreakdownTableView.delegate = self
		quizBreakdownTableView.dataSource = self
		quizBreakdownTableView.register(QuizBreakdownCell.self, forCellReuseIdentifier: String(describing: QuizBreakdownCell.self))
		quizBreakdownTableView.register(QuizBreakdownHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: QuizBreakdownHeader.self))
		
		//quizBreakdownTableView.rowHeight = UITableView.automaticDimension
		//quizBreakdownTableView.estimatedRowHeight = 100
		quizBreakdownTableView.backgroundColor = .clear
		//quizBreakdownTableView.allowsSelection = false
		quizBreakdownTableView.allowsMultipleSelection = false
	}
	
	@IBAction func buttonClicked(_ sender: UIButton) {
		//TODO: - Segue to highscores with name (from nameTextField and score)
		navigationController?.popToRootViewController(animated: true)
	}
	
	private func analyzeScore(_ score: Int){
		let evaluation = score/quiz.questions.count
	}
	
	private func cellToggle(at indexPath: IndexPath){
		isOriginalAnswer[indexPath.row] = !isOriginalAnswer[indexPath.row]
	}
}

//MARK: - UITableViewDelegate & DataSource
extension GameResultViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return quiz.questions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// create cell
		let cell = QuizBreakdownCell()
		
		cell.configureView(withQuestion: quiz.questions[indexPath.row],
						   withUserAnswer: quiz.playerAnswers[indexPath.row],
						   withNumber: indexPath.row + 1)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print("Select \(indexPath.section) \(indexPath.row)")
		guard let cell = tableView.cellForRow(at: indexPath) as? QuizBreakdownCell else { return }
		let playerAnswer = quiz.playerAnswers[indexPath.row]
		let question = quiz.questions[indexPath.row]
		
		tableView.deselectRow(at: indexPath, animated: !playerAnswer.isCorrect)
		
		if !playerAnswer.isCorrect {
			if isOriginalAnswer[indexPath.row] {
				cell.toggleAnswer(with: question.correctAnswer)
			}
			else {
				cell.toggleAnswer(with: playerAnswer)
			}
			isOriginalAnswer[indexPath.row] = !isOriginalAnswer[indexPath.row]
		}
	}
	
//	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//		if section == 0 { return "Your Answers" }
//		else { return nil }
//	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: QuizBreakdownHeader.self)) as? QuizBreakdownHeader {
			header.title.text = quiz.questions.first?.category.description
			header.contentView.backgroundColor = UIColor.appColor(.black)
			return header
		}
		else {
			return UITableViewHeaderFooterView()
		}
	}
}
