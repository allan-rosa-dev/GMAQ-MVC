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
	var playerGotHighScore: Bool = false
	
	@IBOutlet weak var resultsLabel:  UILabel!
	@IBOutlet weak var quizBreakdownTableView: UITableView!
	@IBOutlet weak var nameTextField: UITextField!
	
	//MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.isNavigationBarHidden = true
		nameTextField.delegate = self
		initializeHideKeyboard()
		configureTableView()
		analyzeScore(quiz)
		debugStuff()
    }
	
	// MARK: - Methods
	func debugStuff(){
		let gesture = UITapGestureRecognizer()
		gesture.numberOfTapsRequired = 4
		gesture.addTarget(self, action: #selector(displayHighScoreDialog))
		view.addGestureRecognizer(gesture)
	}
	
	@objc func displayHighScoreDialog(){
		print("DevCheat!")
		let alert = UIAlertController(title: "Reset High Score?", message: nil, preferredStyle: .actionSheet)
		let resetAction = UIAlertAction(title: "Reset", style: .destructive, handler: { _ in
			ScoreManager.shared.clear(category: self.quiz.currentQuestion.category)
		})
		let setHighScoreAction = UIAlertAction(title: "Set 999 High Score", style: .default) { _ in
			self.quiz.score = 999
			self.analyzeScore(self.quiz)
		}
		alert.addAction(resetAction)
		alert.addAction(setHighScoreAction)
		present(alert, animated: true)
	}
	
	fileprivate func configureTableView(){
		quizBreakdownTableView.delegate = self
		quizBreakdownTableView.dataSource = self
		quizBreakdownTableView.register(QuizBreakdownCell.self, forCellReuseIdentifier: String(describing: QuizBreakdownCell.self))
		quizBreakdownTableView.register(QuizBreakdownHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: QuizBreakdownHeader.self))
		
		quizBreakdownTableView.backgroundColor = .clear
		quizBreakdownTableView.allowsMultipleSelection = false
	}
	
	@IBAction func buttonClicked(_ sender: UIButton) {
		//TODO: - Segue to highscores with name (from nameTextField and score)
		guard let playerName = nameTextField.text else { return }
		let alertTitle, alertMessage: String
		
		if playerGotHighScore {
			alertTitle = "Confirm your name"
			alertMessage = "Is the name \(playerName) correct?"
		}
		else {
			alertTitle = "Return to home screen?"
			alertMessage = ""
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
			self.dismiss(animated: true, completion: nil)
		}
		let confirmAction = UIAlertAction(title: "Confirm", style: .default){ _ in
			if self.playerGotHighScore {
				print("ADDING HIGH SCORE: \(playerName) got \(self.quiz.score) points!") //todo
				ScoreManager.shared.addRecord(score: self.quiz.score, username: playerName, to: self.quiz.currentQuestion.category)
			}
			ScoreManager.shared.save(category: self.quiz.currentQuestion.category)
			self.returnToHome()
		}
		let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
		alert.addAction(cancelAction)
		alert.addAction(confirmAction)
		
		present(alert, animated: true, completion: nil)
	}
	
	private func analyzeScore(_ quiz: Quiz) {
		// check for highscore
		let cutoffScore = ScoreManager.shared.highScoreCutoff(for: quiz.currentQuestion.category)
		if quiz.score > cutoffScore {
			resultsLabel.text = "You've got a highscore, with \(quiz.score) points!"
			print(resultsLabel.text!)
			nameTextField.isHidden = false
			playerGotHighScore = true
		}
		else {
			resultsLabel.text = "Your score is \(quiz.score) points!\nYou were \(cutoffScore - quiz.score + 1) points short of making it :("
			print(resultsLabel.text!)
			nameTextField.isHidden = true
			playerGotHighScore = false
		}
	}
	
	private func cellToggle(at indexPath: IndexPath) {
		isOriginalAnswer[indexPath.row] = !isOriginalAnswer[indexPath.row]
	}
	
	//MARK: - Navigation
	private func returnToHome(){
		navigationController?.popToRootViewController(animated: true)
	}
	
	private func goToHighScores(newHighScore score: Int, forUser user: String){
		returnToHome()
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
						   withUserAnswer: quiz.playerAnswers[indexPath.row])
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

//MARK: - UITextFieldDelegate
extension GameResultViewController: UITextFieldDelegate {
	func textFieldDidBeginEditing(_ textField: UITextField) {
		textField.text = ""
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		prepareForEndEditing(textField)
		textField.resignFirstResponder()
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		prepareForEndEditing(textField)
		textField.resignFirstResponder()
	}
	
	//MARK: - Helper functions
	func prepareForEndEditing(_ textField: UITextField){
		guard let text = textField.text else {
			textField.text = "Insert your name"
			return
		}
	}
}
