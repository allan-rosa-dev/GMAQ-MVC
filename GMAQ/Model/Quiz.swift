//
//  Quiz.swift
//  GMAQ
//
//  Created by Allan Rosa on 17/08/21.
//

import Foundation

struct Quiz {
	let questions: [Question]
	var score: Int = 0
	var currentQuestionIndex: Int = 0 {
		didSet {
			if currentQuestionIndex > questions.count {
				print("Finished Quiz. Score = \(score)")
				delegate?.quizDidFinish(self)
			}
		}
	}
	var currentQuestion: Question {
		if questions.count > 0 && currentQuestionIndex < questions.count {
			return questions[currentQuestionIndex]
		}
		else {
			print("< Empty Question >")
			return Question()
		}
	}
	var playerAnswers = [Answer]()
	var delegate: QuizDelegate?
	
	mutating func analyzeAnswer(_ answer: Answer) -> Bool {
		playerAnswers.append(answer) // creating the backlog for the player answers to be shown on quiz breakdown
		currentQuestionIndex += 1
		if answer.isCorrect {
			self.score += 1
			return true
		}
		else {
			self.score -= 1 // >:)
			return false
		}
	}
}

protocol QuizDelegate {
	func quizDidFinish(_ quiz: Quiz)
}
