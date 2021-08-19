//
//  GameViewController.swift
//  GMAQ
//
//  Created by Allan Rosa on 12/08/21.
//

import UIKit

class GameViewController: UIViewController {

	@IBOutlet weak var questionTextLabel: UILabel!
	@IBOutlet weak var answerButton0: UIButton!
	@IBOutlet weak var answerButton1: UIButton!
	@IBOutlet weak var answerButton2: UIButton!
	@IBOutlet weak var answerButton3: UIButton!
	
	var questions = [Question]()
	var quizIndex = 0
	var quiz = Quiz(questions: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		//remove code
		//let url = "https://opentdb.com/api.php?amount=1&category=31&encode=base64"
		
		OpentdbAPIService.shared.createQuiz(numberOfQuestions: 10, category: .animeAndManga, difficulty: .none) { quiz in
			DispatchQueue.main.async {
				self.quiz = quiz
				self.setupQuestion()
			}
		}
		setupQuestion()
	}
	
	func setupQuestion(){
		questionTextLabel.text = questions[quizIndex].text
		
		let answers = quiz.currentQuestion.answers
		
		answerButton0.setTitle(answers[0].text, for: .normal)
		answerButton1.setTitle(answers[1].text, for: .normal)
		
		if quiz.currentQuestion.isMultiple {
			answerButton2.setTitle(answers[2].text, for: .normal)
			answerButton3.setTitle(answers[3].text, for: .normal)
		}
		else {
			answerButton2.isHidden = true
			answerButton3.isHidden = true
		}
	}
	
	@IBAction func answerButtonClicked(_ sender: UIButton) {
		let playerAnswer = quiz.currentQuestion.answers[sender.tag]
		quiz.analyzeAnswer(playerAnswer)
		//questions[quizIndex].analyzeAnswer(userAnswer: sender.tag)
	}

}
