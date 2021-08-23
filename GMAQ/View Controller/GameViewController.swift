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
	
	var quiz = Quiz(questions: [])
	
	override func viewDidLoad() {
		super.viewDidLoad()

		setupQuestion()
	}
	
	private func setupQuestion(){
		questionTextLabel.text =  quiz.currentQuestion.text
		
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
		let isCorrect = quiz.analyzeAnswer(playerAnswer)
		
		print("\(playerAnswer.text) is \(isCorrect ? "Correct!" : "Wrong!") -> Current score: \(quiz.score)")
		
		sender.provideVisualFeedback()
		sender.backgroundColor = isCorrect ? UIColor.appColor(.green) : UIColor.appColor(.red)

		// flash answer result animation AND AFTERWARDS setupQuestion
		DispatchQueue.main.asyncAfter(deadline: .now() + 1){
			self.setupQuestion()
		}
		
	}

}
