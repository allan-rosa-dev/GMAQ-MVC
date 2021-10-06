//
//  GameViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class GameViewController: UIViewController {

	@IBOutlet weak var questionTextLabel: UILabel!
	@IBOutlet weak var quizProgressLabel: UILabel!
	@IBOutlet weak var answerButton0: UIButton!
	@IBOutlet weak var answerButton1: UIButton!
	@IBOutlet weak var answerButton2: UIButton!
	@IBOutlet weak var answerButton3: UIButton!
	
	var quiz = Quiz(from: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()

		quiz.delegate = self
		setupQuestion()
	}
	
	private func setupQuestion(){
		quizProgressLabel.text = "Question (\(quiz.currentQuestionIndex+1)/\(quiz.questions.count))"
		questionTextLabel.text = quiz.currentQuestion.text
		
		let answers = quiz.currentQuestion.answers
		
		answerButton0.configure(with: answers[0])
		answerButton1.configure(with: answers[1])
		
		if quiz.currentQuestion.isMultiple {
			answerButton2.configure(with: answers[2])
			answerButton3.configure(with: answers[3])
		}
		else {
			answerButton2.isHidden = true
			answerButton3.isHidden = true
		}
	}
	
	@IBAction func answerButtonClicked(_ sender: UIButton) {
		let playerAnswer = quiz.currentQuestion.answers[sender.tag]
		let color = playerAnswer.isCorrect ? UIColor.appColor(.green) : UIColor.appColor(.red)
		sender.provideVisualFeedback(color: color)

		DispatchQueue.main.asyncAfter(deadline: .now() + 1){ // execute after 1s
			self.quiz.updateProgress(with: playerAnswer)
			self.setupQuestion()
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! GameResultViewController
		destinationVC.quiz = self.quiz
	}
}

//MARK: - QuizDelegate
extension GameViewController: QuizDelegate {
	func quizDidFinish(_ quiz: Quiz) {
		performSegue(withIdentifier: K.App.View.Segue.gameToResults, sender: self)
	}
}
